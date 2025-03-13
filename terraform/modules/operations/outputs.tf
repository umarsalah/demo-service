output "repository_id" {
  value       = google_artifact_registry_repository.curamet-repo.repository_id
  description = "Repository ID where the docker images will be stored"
}

output "connection_name" {
  value       = google_cloudbuildv2_connection.demo-service-connection.name
  description = "Connection name to github"
}

output "repository_name" {
  value       = google_cloudbuildv2_repository.demo-service-repo.name
  description = "Repository name in cloudbuild"
}

output "trigger_id" {
  value       = google_cloudbuild_trigger.repo-trigger.id
  description = "Trigger ID for the repository"
}

output "trigger_filename" {
  value       = google_cloudbuild_trigger.repo-trigger.filename
  description = "Trigger filename"
}

output "trigger_name" {
  value       = google_cloudbuild_trigger.repo-trigger.name
  description = "Trigger name"
}

output "trigger_project" {
  value       = google_cloudbuild_trigger.repo-trigger.project
  description = "Trigger project"
}
