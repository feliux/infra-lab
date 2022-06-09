variable "region" {
  description = "Region for cloud resources"
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Cluster name"
  default     = "my-eks-cluster"
}

variable "cluster_namespace" {
  description = "Kubernetes namespace"
  default     = "test"
}

variable "console_user" {
  description = "View nodes and workloads for all clusters in the AWS Management Console"
  default     = "me"
}

variable "credentials" {
  description = "Service account credentials"
  default     = "./secrets/creds"
}

variable "profile" {
  default = "develop"
}
