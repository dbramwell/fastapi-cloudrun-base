provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = base64decode(var.credentials_json_base64)
}

provider "google-beta" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = base64decode(var.credentials_json_base64)
}

resource "google_cloud_run_v2_service" "default" {
  name                = "${var.env_name}-cloudrun-service"
  location            = var.region
  deletion_protection = false
  ingress             = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = var.image
    }
  }
}

resource "google_cloud_run_service_iam_binding" "default" {
  location = var.region
  service  = google_cloud_run_v2_service.default.name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}

module "lb-http" {
  source  = "terraform-google-modules/lb-http/google//modules/serverless_negs"
  version = "~> 12.0"

  name    = var.env_name
  project = var.project_id

  ssl                             = true
  managed_ssl_certificate_domains = ["${var.domain}"]
  https_redirect                  = true

  backends = {
    default = {
      description = null
      groups = [
        {
          group = google_compute_region_network_endpoint_group.cloudrun_neg.id
        }
      ]
      enable_cdn = false

      iap_config = {
        enable = false
      }
      log_config = {
        enable = false
      }
    }
  }
}

resource "google_compute_region_network_endpoint_group" "cloudrun_neg" {
  name                  = "${var.env_name}-cloudrun-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = google_cloud_run_v2_service.default.name
  }
}

resource "google_dns_record_set" "frontend" {
  name = "${var.domain}."
  type = "A"
  ttl  = 300

  managed_zone = var.managed_zone

  rrdatas = [module.lb-http.external_ip]
}
