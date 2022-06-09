apiVersion: v1
data:
  mapRoles: |
    - groups:
      - system:bootstrappers
      - system:nodes
      rolearn: ${cluster_nodes_role}
      username: system:node:{{EC2PrivateDNSName}}
  mapUsers: |
    - userarn: ${console_user_arn}
      username: ${console_user}
      groups:
      - eks-console-dashboard-full-access-group
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system