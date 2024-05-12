output "databricks_url" {
  value = "https://${azurerm_databricks_workspace.az_databricks.workspace_url}/"
}
/*
output "notebook_url" {
  value = databricks_notebook.notebook_ml.url
}
*/
output "job_single_existing_cluster" {
  value = databricks_job.job_single_existing_cluster.url
}
/*
output "job_single" {
  value = databricks_job.job_single.url
}
*/
/*
output "job_main_url" {
  value = databricks_job.job_main.url
}
*/
