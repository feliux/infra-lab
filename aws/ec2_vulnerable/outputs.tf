output "server_ip" {
  value = aws_instance.ubuntu_server.public_ip
}

output "elastic_ip" {
  value = aws_eip.ip_ubuntu.public_ip
}

output "elastic_ip_intruder" {
  value = aws_eip.ip_ubuntu_intruder.public_ip
}
