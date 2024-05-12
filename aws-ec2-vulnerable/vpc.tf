resource "aws_vpc" "ec2_vpc" {
  cidr_block           = var.custom_vpc.cidr_block
  enable_dns_hostnames = var.custom_vpc.enable_dns_hostnames
  enable_dns_support   = var.custom_vpc.enable_dns_support
  tags = {
    name      = var.custom_vpc.name
    terraform = true
  }
}

// This will attach a public ip to our instance
resource "aws_eip" "ip_ubuntu" {
  instance = aws_instance.ubuntu_server.id
  vpc      = true
  tags = {
    name      = var.custom_vpc.gateway_name
    terraform = true
  }
}

resource "aws_eip" "ip_ubuntu_intruder" {
  instance = aws_instance.ubuntu_intruder.id
  vpc      = true
  tags = {
    name      = var.custom_vpc.gateway_name
    terraform = true
  }
}

# In order to route traffic from the internet to our VPC we need to set up an internet gateway
resource "aws_internet_gateway" "gw_ubuntu" {
  vpc_id = aws_vpc.ec2_vpc.id
  tags = {
    name      = var.custom_vpc.gateway_name
    terraform = true
  }
}

# Subnet
resource "aws_subnet" "ec2_subnet" {
  cidr_block        = var.custom_vpc.cidr_block_subnet
  vpc_id            = aws_vpc.ec2_vpc.id
  availability_zone = var.custom_vpc.subnet_availability_zone
}

# Route tables
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.ec2_vpc.id
  route {
    cidr_block = var.custom_vpc.route_table_cidr_block
    gateway_id = aws_internet_gateway.gw_ubuntu.id
  }
  tags = {
    name      = var.custom_vpc.route_table_name
    terraform = true
  }
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.ec2_subnet.id
  route_table_id = aws_route_table.route_table.id
}
