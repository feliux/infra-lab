### Environment for deploying Tcloud

variable "subscription_id" {
  type    = string
  default = ""
}

variable "client_id" {
  type    = string
  default = ""
}

variable "client_secret" {
  type    = string
  default = ""
}

variable "tenant_id" {
  type    = string
  default = ""
}

variable "me_email" {
  type    = string
  default = ""
}

### Resources

variable "environment" {
  type    = string
  default = "develop"
}

variable "azure_rosources" {
  description = "Azure resources description"
  default = {
    "resource_group_name"               = "databricks"
    "location"                          = "West Europe"
    "databricks_name"                   = "databricks-test"
    "databricks_sku"                    = "trial"            # Sku to use for the Databricks Workspace. Possible values are standard, premium, or trial
    "managed_resource_group_name"       = "databricks-dev-1" # Has to be unique
    "customer_managed_key_enabled"      = false              # true only if sku = "premium"
    "infrastructure_encryption_enabled" = false              # true only if sku = "premium"
    "public_network_access_enabled"     = true
  }
}

### Databricks

variable "databricks_clusters" {
  description = "Databricks clusters description"
  default = {
    single_node = {
      "name"                    = "Single_Node_Cluster"
      "autotermination_minutes" = 15
      "local_disk"              = true
      "spark_version"           = "latest"
      "ml"                      = true
    }
    main_cluster = {
      "name"                    = "Main_Autoscaling"
      "autotermination_minutes" = 15
      "autoscale_min_workers"   = 1
      "autoscale_max_workers"   = 2
      "spark_version"           = "latest"
    }
    gpu_cluster = {
      "name"                    = "GPU_Research_Cluster"
      "autotermination_minutes" = 15
      "autoscale_min_workers"   = 1
      "autoscale_max_workers"   = 2
      "min_cores"               = 8
      "local_disk"              = true
      "gb_per_core"             = 1
      "min_gpus"                = 1
      "spark_version"           = "3.0.1"
      "ml"                      = true
    }
  }
}

variable "databricks_jobs" {
  description = "Databricks jobs description"
  default = {
    job_single = {
      "name"               = "automl-forecasting-covid"
      "notebook_path_name" = "notebooks/dbc/automl-forecasting-covid.dbc"
    }
    job_single_cluster = {
      "name" = "numpy-job_cluster"
    }
  }
}

variable "databricks_notebooks" {
  description = "Databricks jobs description"
  default = {
    "notebooks_dbc_path" = "notebooks/dbc"
    "notebooks_py_path"  = "notebooks/python"
  }
}
