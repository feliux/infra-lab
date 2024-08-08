# kops

Deploy a k8s cluster on AWS using kops.

## Usage

**Creating resources**

Create a s3 bucket for storing kops state. Then create the cluster.

Also, you can use kops to generate terraform configurations for your cluster (see [here](https://kops.sigs.k8s.io/terraform/)).


```sh
$ terraform init
$ terraform plan -out tfplan
$ terraform apply --auto-approve

$ kops create cluster \
    --cloud=aws \
    --name=$(terraform output -raw cluster_name) \
    --region=$(terraform output az) \
    --state=s3://$(terraform output -raw s3_bucket) \
    --discovery-store=s3://$(terraform output s3_bucket)/discovery \
    --dry-run -o yaml | tee ./cluster.yaml
$ kops create cluster \
    --filename ./cluster.yaml \
    --state=s3://$(terraform output -raw s3_bucket)
$ kops update cluster \
    --name=$(terraform output cluster_name) \
    --state=s3://$(terraform output -raw s3_bucket) \
    --yes \
    --admin
$ kops validate cluster \
    --wait=10m \
    --state=s3://$(terraform output -raw s3_bucket)

$ kubectl run --rm --stdin --image=hello-worls --restart=Never --request-timeout=30 test-pod
```

**Deleting resources**

Be sure to make a terraform destroy after deleting kops resources.

```sh
$ kops delete cluster \
    --name=$(terraform output cluster_name) \
    --state=s3://$(terraform output -raw s3_bucket) \
    --yes
 
$ terraform destroy --auto-approve
```

## References

[kops](https://kops.sigs.k8s.io/)

[kops github](https://github.com/kubernetes/kops)
