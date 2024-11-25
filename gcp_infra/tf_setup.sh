# This is the stuff I ran once to set up the GCP project for Terraform.
# Probably better ways to do this.
export PROJECT_ID=dbramler-tech-tasks
gcloud iam service-accounts create tf-service-account --description="Terraform Service account" --display-name="Terraform Service account"
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:tf-service-account@$PROJECT_ID.iam.gserviceaccount.com" --role="roles/editor"
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:tf-service-account@$PROJECT_ID.iam.gserviceaccount.com" --role="roles/run.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:tf-service-account@$PROJECT_ID.iam.gserviceaccount.com" --role="roles/compute.networkAdmin"
gcloud iam service-accounts set-iam-policy tf-service-account@$PROJECT_ID.iam.gserviceaccount.com policy.json
gsutil mb -l gs://tf-state
gsutil versioning set on gs://tf-state
gcloud artifacts repositories create dbramler-tech-tasks-repo --location=europe-west2 --repository-format=docker
gcloud auth configure-docker europe-west2-docker.pkg.dev --quiet