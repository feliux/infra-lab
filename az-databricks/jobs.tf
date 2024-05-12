resource "databricks_job" "job_single_existing_cluster" {
  name                = var.databricks_jobs.job_single.name
  existing_cluster_id = databricks_cluster.single_node_cluster.id

  notebook_task {
    notebook_path = "${data.databricks_current_user.current_user.home}/${var.databricks_jobs.job_single.notebook_path_name}"
  }

  email_notifications {
    on_success = [
      var.me_email
    ]
    on_failure = [
      var.me_email
    ]
  }
}
/*
resource "databricks_job" "job_single" {
  name = var.databricks_jobs.job_single_cluster.name

  new_cluster {
    num_workers   = 1
    spark_version = var.databricks_clusters.single_node.spark_version == "latest" ? data.databricks_spark_version.spark_latest_version.id : "3.0.1"
    node_type_id  = data.databricks_node_type.single_node.id

    spark_conf = {
      "spark.databricks.cluster.profile" : "singleNode"
      "spark.master" : "local[*]"
    }

    custom_tags = {
      "ResourceClass" = "SingleNode"
    }
  }

  notebook_task {
    notebook_path = databricks_notebook.notebook_ml.path
  }

  email_notifications {
    on_success = [
      var.me_email
    ]
    on_failure = [
      var.me_email
    ]
  }
}
*/
/*
resource "databricks_job" "job_main" {
  name = "Job with multiple tasks"
  always_running = false

  task {
    task_key = "task1"

    new_cluster {
        num_workers   = 1
        spark_version = var.databricks_clusters.main_cluster.spark_version == "latest" ? data.databricks_spark_version.spark_latest_version.id : "3.0.1"
        node_type_id  = data.databricks_node_type.single_node.id
    }

    notebook_task {
      notebook_path = databricks_notebook.notebook_ml.path
    }
  }

  task {
    task_key = "task2"

    depends_on {
      task_key = "task1"
    }

    existing_cluster_id = databricks_cluster.main_cluster.id

    library {
        pypi {
            package = "pandas"
        }
    }
    library {
        pypi {
            package = "numpy"
        }
    }

    notebook_task {
      notebook_path = databricks_notebook.notebook_py.path
    }
  }
}
*/
