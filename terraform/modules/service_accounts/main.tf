provider "google" {
  project = var.project
  region  = var.region
}


resource "google_service_account" "service_account" {
  for_each     = var.service_accounts
  account_id   = "${var.prefix}-${each.value.name}"
  display_name = each.value.display_name
}

resource "google_project_iam_member" "demo_service_account_roles" {
  for_each           = {for membership in local.sa_roles : "${membership.name}-${membership.role}" => membership}
  project            = var.project
  role               = each.value.role
  member             = "serviceAccount:${var.prefix}-${each.value.name}@${var.project}.iam.gserviceaccount.com"
  depends_on         = [google_service_account.service_account]
}


locals {
  sa_roles = flatten([
    for sa in var.service_accounts : [
      for role_key, role in sa.roles : {
        name = sa.name
        role = role
      }
    ]
  ])
}
