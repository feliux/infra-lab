# EKS

Deploy Kubernetes cluster on AWS.

## Prerequisites

- AWS account.

- `kubectl` installed.

- `aws-iam-authenticator` added to your `$PATH`.

```sh
$ curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
$ chmod +x ./aws-iam-authenticator

$ export PATH=$PATH:$PWD
```

## Usage

```sh
$ terraform init
$ terraform plan
$ terraform apply -auto-approve
```

At this point, you can see the following message from the EKS UI

~~~
Your current user or role does not have access to Kubernetes objects on this EKS cluster
This may be due to the current user or role not having Kubernetes RBAC permissions to describe cluster resources or not having an entry in the cluster’s auth config map.
~~~

This warning is automatically solved with the kubernetes configuration deployment from the [eks_resoruces](../eks_resources/) folder

```sh
$ cd ../eks_resources

$ terraform init
$ terraform plan
$ terraform apply -auto-approve

$ kubectl get nodes --kubeconfig kubeconfig-my-eks-cluster-name
```

## References

[Create Kubernetes Cluster](https://github.com/hashicorp/terraform-provider-kubernetes/tree/main/_examples/eks)

[EKS provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster)

[Kubernetes provider](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs)

[Helm provider](https://registry.terraform.io/providers/hashicorp/helm/latest/docs)

[EKS roles module](https://github.com/arkhoss/terraform-aws-eks-roles)
