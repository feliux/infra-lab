resource "databricks_cluster" "single_node_cluster" {
  cluster_name            = var.databricks_clusters.single_node.name
  spark_version           = var.databricks_clusters.single_node.spark_version == "latest" ? data.databricks_spark_version.spark_latest_version.id : "3.0.1"
  node_type_id            = data.databricks_node_type.single_node.id
  autotermination_minutes = var.databricks_clusters.single_node.autotermination_minutes

  spark_conf = {
    "spark.databricks.cluster.profile" : "singleNode"
    "spark.master" : "local[*]"
  }

  spark_env_vars = {
    TERRAFORM = "YES"
    ENV       = "DEPLOY"
  }

  library {
    pypi {
      #package = "fbprophet"
      package = "numpy"
      // repo can also be specified here
    }
  }

  custom_tags = {
    ResourceClass = "SingleNode"
    Environment   = var.environment
  }
}

/*
resource "databricks_cluster" "main_cluster" {
  cluster_name            = var.databricks_clusters.main_cluster.name
  spark_version           = var.databricks_clusters.main_cluster.spark_version == "latest" ? data.databricks_spark_version.spark_latest_version.id : "3.0.1"
  node_type_id            = data.databricks_node_type.single_node.id
  autotermination_minutes = var.databricks_clusters.main_cluster.autotermination_minutes
  spark_env_vars = {
      TERRAFORM = "YES"
      ENV = "DEPLOY"
  }

  autoscale {
    min_workers = var.databricks_clusters.main_cluster.autoscale_min_workers
    max_workers = var.databricks_clusters.main_cluster.autoscale_max_workers
  }

  library {
    pypi {
        package = "numpy"
        // repo can also be specified here
    }
  }

  custom_tags = {
    Environment   = var.environment
  }
}
*/

/*
resource "databricks_cluster" "gpu_cluster" {
    cluster_name            = var.databricks_clusters.gpu_cluster.name
    spark_version           = var.databricks_clusters.gpu_cluster.spark_version == "latest" ? data.databricks_spark_version.spark_latest_version.id : "3.0.1"
    node_type_id            = data.databricks_node_type.node_with_gpu.id
    autotermination_minutes = var.databricks_clusters.gpu_cluster.autotermination_minutes
    autoscale {
        min_workers = var.databricks_clusters.gpu_cluster.autoscale_min_workers
        max_workers = var.databricks_clusters.gpu_cluster.autoscale_max_workers
    }
}
*/
