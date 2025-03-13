variable "project" {
  type = string
}
variable "region" {
  type    = string
  default = "europe-west1"
}

variable "project_number" {
  type = string
}

variable "location" {
  type    = string
  default = "EU"
}

variable "envname" {
  type    = string
  default = "dev"
}

variable "prefix" {
  type    = string
  default = "dev"
}


variable "run_version" {
  type = string
}

variable "run_service_name" {
  type = string
}

variable "github_oauth_token_secret_version" {
  type = string
}

variable "github_app_installation_id" {
  type = string
}

variable "repo_name" {
  type = string
}

variable "instance_name" {
  description = "The name of the Cloud SQL instance"
  type        = string
}

variable "database_version" {
  description = "The database version (e.g., POSTGRES_12, MYSQL_5_7)"
  type        = string
}

variable "tier" {
  description = "The machine type (e.g., db-f1-micro, db-n1-standard-1)"
  type        = string
}

variable "db_user_name" {
  description = "The name of the user to create"
  type        = string
}

variable "db_user_password" {
  description = "The root password for the database"
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "The name of the database to create"
  type        = string
}
