variable "region" {
  description = "Region for cloud resources"
  default     = "us-east-1"
}

variable "cluster" {
  default = {
    cluster_name    = "my-eks-cluster"
    cluster_version = "1.21"
    instance_types  = ["t3.medium"]
    desired_size    = 3
    max_size        = 5
    min_size        = 2

  }
}

variable "custom_vpc" {
  default = {
    name                     = "custom_vpc_k8s"
    cidr_block               = "10.0.0.0/16"
    cidr_block_subnet        = "10.0.0.0/24"
    enable_dns_hostnames     = true
    enable_dns_support       = true
    subnet_availability_zone = "us-east-1a"
    route_table_name         = "route-table-k8s"
    route_table_cidr_block   = "0.0.0.0/0"
  }
}
