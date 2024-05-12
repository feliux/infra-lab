resource "local_sensitive_file" "kubeconfig" {
  content = templatefile("${path.module}/templates/kubeconfig.tpl", {
    cluster_name = var.cluster_name,
    clusterca    = data.aws_eks_cluster.default.certificate_authority[0].data,
    endpoint     = data.aws_eks_cluster.default.endpoint,
  })
  filename = "./kubeconfig-${var.cluster_name}"
}

resource "local_sensitive_file" "aws_auth" {
  content = templatefile("${path.module}/templates/aws-auth-cm.tpl", {
    cluster_nodes_role = data.aws_iam_role.node_role.arn,
    console_user       = data.aws_iam_user.console_user.user_name,
    console_user_arn   = data.aws_iam_user.console_user.arn,
  })
  filename = "./resources/aws-auth-cm-tpl.yaml"
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.cluster_namespace
  }
}

resource "null_resource" "setup_cluster_binding" {
  //count = var.cluster_role_binding_qty
  provisioner "local-exec" {
    //command     = "kubectl apply -f ${path.module}/cluster-roles-binding/${var.cluster_roles_binding[count.index]}.yml"
    command     = "kubectl apply -f resources/eks-console-full-access.yaml --kubeconfig kubeconfig-${var.cluster_name}"
    interpreter = ["sh", "-c"]
  }
  depends_on = [
    local_sensitive_file.kubeconfig
  ]
}

resource "null_resource" "setup_config_map" {
  //count = var.overwrite_aws_auth ? 1 : 0
  provisioner "local-exec" {
    command     = "kubectl apply -f resources/aws-auth-cm-tpl.yaml --kubeconfig kubeconfig-${var.cluster_name}"
    interpreter = ["sh", "-c"]
  }
  depends_on = [
    local_sensitive_file.kubeconfig,
    local_sensitive_file.aws_auth,
    null_resource.setup_cluster_binding
  ]
}
