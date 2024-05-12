variable "region" {
  description = "Region for cloud resources"
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "K8s cluster name"
  default     = "my-cluster"
}

variable "cluster_version" {
  description = "K8s cluster version"
  default     = "1.21"
}
