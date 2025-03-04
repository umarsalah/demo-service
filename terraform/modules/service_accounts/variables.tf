variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "prefix" {
    type = string
}

variable "service_accounts" {
    type = map(object({
        name         = string
        display_name = string
        roles        = map(string)
    }))
}

