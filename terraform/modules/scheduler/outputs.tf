output "job_name" {
  value       = google_cloud_scheduler_job.publish-cron.name
  description = "Name of the scheduler job"
}
