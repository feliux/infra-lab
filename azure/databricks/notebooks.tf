resource "databricks_notebook" "notebook_ml" {
  path     = "${data.databricks_current_user.current_user.home}/terraform/numpy.ipynb"
  language = "PYTHON"
  content_base64 = base64encode(
    <<-EOT
    # created from ${abspath(path.module)}
    import numpy as np
    display(spark.range(10))
    EOT
  )
}

resource "databricks_notebook" "notebooks_py" {
  for_each       = fileset("${path.module}/${var.databricks_notebooks.notebooks_py_path}", "*.py")
  path           = "${data.databricks_current_user.current_user.home}/${var.databricks_notebooks.notebooks_py_path}/${each.value}"
  language       = "PYTHON"
  content_base64 = filebase64("${path.module}/${var.databricks_notebooks.notebooks_py_path}/${each.value}")

  depends_on = [
    data.databricks_current_user.current_user
  ]
}

resource "databricks_notebook" "notebooks_dbc" {
  for_each = fileset("${path.module}/${var.databricks_notebooks.notebooks_dbc_path}", "*.dbc")
  source   = "${path.module}/${var.databricks_notebooks.notebooks_dbc_path}/${each.value}"
  path     = "${data.databricks_current_user.current_user.home}/${var.databricks_notebooks.notebooks_dbc_path}/${each.value}"

  depends_on = [
    data.databricks_current_user.current_user
  ]
}
