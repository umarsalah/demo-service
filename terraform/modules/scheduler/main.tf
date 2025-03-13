resource "google_cloud_scheduler_job" "publish-cron" {
  name             = "${var.prefix}-publish"
  description      = "test http job"
  schedule         = "*/8 * * * *" # every 8 minutes
  time_zone        = "America/New_York"
  attempt_deadline = "320s"

  retry_config {
    retry_count = 1
  }

  http_target {
    http_method = "POST"
    uri         = "${var.run_service_url}/publish"
    body        = base64encode("{\"foo\":\"bar\"}")
    headers = {
      "Content-Type" = "application/json"
    }
  }
}
