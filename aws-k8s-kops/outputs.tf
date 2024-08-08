output "s3_bucket" {
  value = aws_s3_bucket.kops_bucket.id
}

output "az" {
  value = data.aws_availability_zones.available.names[0]
}

// Kops will set up this DNS for cluster internal communication without having to create public DNS records
output "cluster_name" {
  value = "kops-cluster-${random_string.random.result}.k8s.local"
}
