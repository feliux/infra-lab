data "aws_eks_cluster" "default" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "default" {
  name = var.cluster_name
}

data "aws_iam_role" "node_role" {
  name = "${var.cluster_name}-node"
}

data "aws_iam_user" "console_user" {
  user_name = var.console_user
}
