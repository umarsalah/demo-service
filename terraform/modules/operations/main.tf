provider "google" {
  project = var.project
  region  = var.region
}

# enable apis
resource "google_project_service" "enabled_apis" {
  for_each = local.enable_apis

  service                    = each.value
  disable_dependent_services = false
  disable_on_destroy         = false
}


resource "google_artifact_registry_repository" "curamet-repo" {
  repository_id = "${var.prefix}-curamet-repo"
  description   = "example docker repository"
  project       = var.project
  location      = "europe"
  format        = "DOCKER"
  depends_on    = [google_project_service.enabled_apis]
}

resource "google_cloudbuildv2_connection" "demo-service-connection" {
  location = "us-central1"
  name     = "github-connection"

  github_config {
    app_installation_id = var.github_app_installation_id
    authorizer_credential {
      oauth_token_secret_version = var.github_oauth_token_secret_version
    }
  }
}

resource "google_cloudbuildv2_repository" "demo-service-repo" {
  location          = "us-central1"
  name              = var.repo_name
  parent_connection = google_cloudbuildv2_connection.demo-service-connection.name
  remote_uri        = "https://github.com/curamet/demo-service.git"
}

resource "google_cloudbuild_trigger" "repo-trigger" {
  location = "us-central1"

  repository_event_config {
    repository = google_cloudbuildv2_repository.demo-service-repo.id
    push {
      branch = "main"
    }
  }

  filename = "cloudbuild.yaml"
}

locals {
  // Go to: https://console.cloud.google.com/apis/library to see apis list
  enable_apis = {
    "artifactregistry.googleapis.com" = "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com"       = "cloudbuild.googleapis.com",
    "cloudRun.googleapis.com"         = "run.googleapis.com",
    "secretmanager.googleapis.com"    = "secretmanager.googleapis.com",
    "cloudstorage.googleapis.com"     = "storage-component.googleapis.com",
    "pubsub.googleapis.com"           = "pubsub.googleapis.com"
  }
}
