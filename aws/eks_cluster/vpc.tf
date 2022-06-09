resource "aws_vpc" "k8s-acc" {
  cidr_block           = var.custom_vpc.cidr_block
  enable_dns_hostnames = var.custom_vpc.enable_dns_hostnames
  enable_dns_support   = var.custom_vpc.enable_dns_support

  tags = {
    "Name"                                              = var.custom_vpc.name
    "kubernetes.io/cluster/${var.cluster.cluster_name}" = "shared"
    Terraform                                           = true
  }
}

resource "aws_subnet" "k8s-acc" {
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24" // var.custom_vpc.cidr_block_subnet
  vpc_id                  = aws_vpc.k8s-acc.id
  map_public_ip_on_launch = true

  tags = {
    "Name"                                              = var.custom_vpc.name
    "kubernetes.io/cluster/${var.cluster.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                            = 1
    Terraform                                           = true
  }
}

resource "aws_internet_gateway" "k8s-acc" {
  vpc_id = aws_vpc.k8s-acc.id

  tags = {
    Name      = var.custom_vpc.name
    Terraform = true
  }
}

resource "aws_route_table" "k8s-acc" {
  vpc_id = aws_vpc.k8s-acc.id

  route {
    cidr_block = var.custom_vpc.route_table_cidr_block
    gateway_id = aws_internet_gateway.k8s-acc.id
  }

  tags = {
    Name      = var.custom_vpc.route_table_name
    Terraform = true
  }
}

resource "aws_route_table_association" "k8s-acc" {
  count = 2

  subnet_id      = aws_subnet.k8s-acc[count.index].id
  route_table_id = aws_route_table.k8s-acc.id
}
