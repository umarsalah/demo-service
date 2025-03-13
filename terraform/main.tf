provider "google" {
  project = var.project
  region  = var.region
}


module "operations" {
  source                            = "./modules/operations"
  project                           = var.project
  region                            = var.region
  prefix                            = var.prefix
  github_app_installation_id        = var.github_app_installation_id
  repo_name                         = var.repo_name
  github_oauth_token_secret_version = var.github_oauth_token_secret_version
}

module "service_accounts" {
  source  = "./modules/service_accounts"
  project = var.project
  region  = var.region
  prefix  = var.prefix
}


module "storage" {
  source                 = "./modules/storage"
  project                = var.project
  region                 = var.region
  prefix                 = var.prefix
  runner_service_account = module.service_accounts.sa_demo_service_runner_email
  depends_on             = [module.operations]
}

module "secret_manager" {
  source     = "./modules/secret_manager"
  prefix     = var.prefix
  depends_on = [module.operations]
}

module "run" {
  source           = "./modules/run"
  project          = var.project
  region           = var.region
  prefix           = var.prefix
  run_version      = var.run_version
  run_service_name = var.run_service_name
  repository_id    = module.operations.repository_id
  service_account  = module.service_accounts.sa_demo_service_runner_email
  bucket_name      = module.storage.bucket_name
  secret_name      = module.secret_manager.secret_name
  depends_on       = [module.service_accounts, module.storage, module.secret_manager, module.operations]
}

module "pubsub" {
  source                  = "./modules/pubsub"
  project                 = var.project
  region                  = var.region
  prefix                  = var.prefix
  run_service_url         = module.run.run_service_url
  invoker_service_account = module.service_accounts.sa_demo_service_invoker_email
  bucket_name             = module.storage.bucket_name
  depends_on              = [module.operations, module.storage]
}

module "db" {
  source           = "./modules/db"
  project          = var.project
  region           = var.region
  prefix           = var.prefix
  instance_name    = var.instance_name
  database_version = var.database_version
  tier             = var.tier
  db_user_name     = var.db_user_name
  db_user_password = var.db_user_password
  database_name    = var.database_name
  depends_on       = [module.operations]

}

module "scheduler" {
  source          = "./modules/scheduler"
  prefix          = var.prefix
  run_service_url = module.run.run_service_url
  depends_on      = [module.operations, module.run]
}
