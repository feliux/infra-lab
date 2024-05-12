resource "google_container_cluster" "default" {
  name               = var.network_name
  location           = var.location
  initial_node_count = 3
  min_master_version = data.google_container_engine_versions.default.latest_master_version
  network            = google_compute_subnetwork.default.name
  subnetwork         = google_compute_subnetwork.default.name

  // Use legacy ABAC until these issues are resolved:
  //   https://github.com/mcuadros/terraform-provider-helm/issues/56
  //   https://github.com/terraform-providers/terraform-provider-kubernetes/pull/73
  enable_legacy_abac = true

  // Wait for the GCE LB controller to cleanup the resources.
  // Wait for the GCE LB controller to cleanup the resources.
  provisioner "local-exec" {
    when    = destroy
    command = "sleep 90"
  }
}