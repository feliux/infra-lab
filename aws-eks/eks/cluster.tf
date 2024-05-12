resource "aws_eks_cluster" "k8s-acc" {
  name     = var.cluster.cluster_name
  version  = var.cluster.cluster_version
  role_arn = aws_iam_role.k8s-acc-cluster.arn

  vpc_config {
    subnet_ids = aws_subnet.k8s-acc.*.id
  }

  depends_on = [
    aws_iam_role_policy_attachment.k8s-acc-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.k8s-acc-AmazonEKSVPCResourceController,
  ]

  tags = {
    Name      = var.custom_vpc.name
    Terraform = true
  }
}

resource "aws_eks_node_group" "k8s-acc" {
  cluster_name    = aws_eks_cluster.k8s-acc.name
  node_group_name = var.cluster.cluster_name
  node_role_arn   = aws_iam_role.k8s-acc-node.arn
  subnet_ids      = aws_subnet.k8s-acc.*.id

  instance_types = var.cluster.instance_types

  scaling_config {
    desired_size = var.cluster.desired_size
    max_size     = var.cluster.max_size
    min_size     = var.cluster.min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.k8s-acc-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.k8s-acc-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.k8s-acc-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Name      = var.custom_vpc.name
    Terraform = true
  }
}
