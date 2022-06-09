output "kubeconfig" {
  value = abspath("${path.root}/${local_sensitive_file.kubeconfig.filename}")
}
