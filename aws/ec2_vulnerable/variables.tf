### ENVIRONMENT ###

variable "region" {
  description = "Region for cloud resources"
  default     = "us-east-1"
}

### NETWORK ###

variable "custom_vpc" {
  default = {
    name                     = "custom_vpc_1"
    cidr_block               = "10.0.0.0/16"
    cidr_block_subnet        = "10.0.0.0/24"
    enable_dns_hostnames     = true
    enable_dns_support       = true
    subnet_availability_zone = "us-east-1a"
    gateway_name             = "gw_ubuntu_server"
    route_table_name         = "route-table-ubuntu"
    route_table_cidr_block   = "0.0.0.0/0"
    security_group_name      = "22/80/8080/443_0"
  }
}

### EC2 ###

variable "ubuntu_server" {
  default = {
    name          = "ubuntu_server"
    instance_type = "t3.nano"
    server_os     = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
    ssh_key_name  = "ssh_ubuntu_server"
    #  ssh_key_path     = "keys/aws_key.pub"
    ssh_key_base64   = "changeme"
    webserver        = "apache2"
    webserver_user   = "www-data" # root for securized
    bash_config_path = "templates/config_victim_lfi.tpl"
  }
}

variable "ubuntu_intruder" {
  default = {
    name             = "ubuntu_intruder"
    instance_type    = "t3.medium"
    bash_config_path = "templates/config_intruder_lfi.tpl"
  }
}
