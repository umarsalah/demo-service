prefix              = "im" # Prefix for the resources -- max two letters
project             = "curamet-onboarding"
project_number      = "696820564091"
region              = "europe-west1"
location            = "EU"
envname             = "dev"



service_accounts = {
  demo_service_runner = {
    name = "sa-demo-service-runner",
    display_name = "Demo Service Runner",
    roles = {
      "logWriter" = "roles/logging.logWriter",
      "secretAccessor" = "roles/secretmanager.secretAccessor",
    }
  },
  demo_service_invoker = {
    name = "sa-demo-service-invoker",
    display_name = "Demo Service Invoker",
    roles = {
      "runInvoker" = "roles/run.invoker"
    }
  }
}
