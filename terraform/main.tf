
provider "google" {
    project = var.project
    region  = var.region
}


module "operations" {
    source = "./modules/operations"
    project = var.project
    region  = var.region
    prefix  = var.prefix
}

module "service_accounts" {
    source           = "./modules/service_accounts"
    project          = var.project
    region           = var.region
    service_accounts = var.service_accounts
    prefix           = var.prefix
}
