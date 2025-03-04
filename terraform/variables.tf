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
  type = string
  default = "EU"
}

variable "envname" {
  type = string
  default = "dev"
}

variable "prefix" {
  type = string
  default = "dev"
}

variable "service_accounts" {
    type = map(object({
        name         = string
        display_name = string
        roles        = map(string)
    }))
}
