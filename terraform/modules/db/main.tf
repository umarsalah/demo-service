resource "google_sql_database_instance" "POSTGRES_12" {
  name             = "${var.prefix}-${var.instance_name}"
  database_version = var.database_version
  region           = var.region
  project          = var.project
  settings {
    tier = var.tier
    ip_configuration {
      ipv4_enabled = true
    }
  }
}


resource "google_sql_database" "db" {
  name = "${var.prefix}-${var.instance_name}"
  instance = google_sql_database_instance.POSTGRES_12.name
  project  = var.project
}

resource "google_sql_user" "user" {
  instance = google_sql_database_instance.POSTGRES_12.name
  name     = var.db_user_name
  password = var.db_user_password
  project  = var.project
}
