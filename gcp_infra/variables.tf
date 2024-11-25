variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = "dbramler-tech-tasks"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-west2"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "europe-west2-b"
}

variable "env_name" {
  description = "Environment name"
  type        = string
  default     = "base"
}

variable "credentials_json_base64" {
  description = "Base64-encoded GCP service account JSON key"
  type        = string
  sensitive   = true
}

variable "image" {
  description = "Docker image to deploy to Google Cloud Run"
  type        = string
  default     = "europe-west2-docker.pkg.dev/dbramler-tech-tasks/dbramler-tech-tasks-repo/test-image"
}

variable "managed_zone" {
  description = "GCP Managed Zone containing the domain we want to use"
  type        = string
  default     = "gcp-davidbramler-click"
}

variable "domain" {
  description = "Domain we want to use for our app"
  type        = string
  default     = "base.gcp.davidbramler.click"
}

variable "tf_state_bucket" {
  description = "GCS bucket to store Terraform state"
  type        = string
  default     = "dbramler-tech-tasks-tf-state"
}
