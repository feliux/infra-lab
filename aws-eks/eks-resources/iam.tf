resource "aws_iam_policy" "eks_custom_policy" {
  name        = "CustomViewAllEKSPolicy"
  path        = "/"
  description = "View nodes and workloads for all clusters in the AWS Management Console"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "eks:DescribeNodegroup",
          "eks:ListNodegroups",
          "eks:DescribeCluster",
          "eks:ListClusters",
          "eks:AccessKubernetesApi",
          "ssm:GetParameter",
          "eks:ListUpdates",
          "eks:ListFargateProfiles"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "console_user_attach" {
  name       = "console_user_attach"
  users      = [var.console_user]
  policy_arn = aws_iam_policy.eks_custom_policy.arn
}
