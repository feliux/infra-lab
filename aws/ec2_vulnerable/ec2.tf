data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name = "name"
    values = [
      var.ubuntu_server.server_os
    ]
  }
}

data "template_file" "config_victim" {
  template = file(var.ubuntu_server.bash_config_path)
  vars = {
    webserver      = var.ubuntu_server.webserver
    webserver_user = var.ubuntu_server.webserver_user
  }
}

data "template_file" "config_intruder" {
  template = file(var.ubuntu_intruder.bash_config_path)
}

resource "aws_key_pair" "ssh_key" {
  key_name = var.ubuntu_server.ssh_key_name
  # public_key = file(var.ubuntu_server.ssh_key_path)
  # public_key = base64decode(var.ubuntu_server.ssh_key_base64)
  public_key = base64decode(var.ssh_public_key)
  tags = {
    terraform = true
  }
}

resource "aws_instance" "ubuntu_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ubuntu_server.instance_type
  user_data     = data.template_file.config_victim.rendered
  subnet_id     = aws_subnet.ec2_subnet.id
  key_name      = aws_key_pair.ssh_key.key_name
  security_groups = [
    aws_security_group.ingress_all.id
  ]
  tags = {
    Name      = var.ubuntu_server.name
    terraform = true
  }
}

resource "aws_instance" "ubuntu_intruder" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ubuntu_intruder.instance_type
  user_data     = data.template_file.config_intruder.rendered
  subnet_id     = aws_subnet.ec2_subnet.id
  key_name      = aws_key_pair.ssh_key.key_name
  security_groups = [
    aws_security_group.ingress_all.id
  ]
  tags = {
    Name      = var.ubuntu_intruder.name
    terraform = true
  }
}
