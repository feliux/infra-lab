resource "databricks_mlflow_experiment" "test" {
  name              = "${data.databricks_current_user.current_user.home}/experiments"
  artifact_location = "dbfs:/tmp/my-experiment"
  description       = "My MLflow experiment"
}

resource "databricks_mlflow_model" "test" {
  name        = "My MLflow model"
  description = "My MLflow model"

  tags {
    key   = "key1"
    value = "value1"
  }

  tags {
    key   = "key2"
    value = "value2"
  }
}
