data "google_client_config" "current" {}

data "google_container_engine_versions" "default" {
  location = var.location
}
