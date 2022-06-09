/*
data "databricks_group" "admins" {
    display_name = "admins"
    depends_on = [
      azurerm_databricks_workspace.az_databricks
      ]
}
*/
/*
data "databricks_user" "me_email" {
  user_name = var.me_email
  depends_on = [
    azurerm_databricks_workspace.az_databricks
  ]
}
*/
data "databricks_current_user" "current_user" {
  depends_on = [
    azurerm_databricks_workspace.az_databricks
  ]
}

data "databricks_node_type" "single_node" {
  local_disk = var.databricks_clusters.single_node.local_disk
  depends_on = [
    azurerm_databricks_workspace.az_databricks
  ]
}

data "databricks_spark_version" "spark_latest_version" {
  long_term_support = true
  ml                = true
  depends_on = [
    azurerm_databricks_workspace.az_databricks
  ]
}

data "databricks_node_type" "gpu_node" {
  local_disk  = var.databricks_clusters.gpu_cluster.local_disk
  min_cores   = var.databricks_clusters.gpu_cluster.min_cores
  gb_per_core = var.databricks_clusters.gpu_cluster.gb_per_core
  min_gpus    = var.databricks_clusters.gpu_cluster.min_gpus
  depends_on = [
    azurerm_databricks_workspace.az_databricks
  ]
}

data "databricks_spark_version" "gpu_spark" {
  gpu           = true
  ml            = var.databricks_clusters.gpu_cluster.ml
  spark_version = var.databricks_clusters.gpu_cluster.spark_version
  depends_on = [
    azurerm_databricks_workspace.az_databricks
  ]
}
