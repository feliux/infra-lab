# GKE

## Set up the environment

1. Set the project with your project ID:

```
PROJECT=YOUR_PROJECT
```

```sh
$ gcloud config set project ${PROJECT}
```

2. Configure the environment for Terraform:

```
[[ $CLOUD_SHELL ]] || gcloud auth application-default login
export GOOGLE_PROJECT=$(gcloud config get-value project)
```

3. Run Terraform

**Testing**

1. Wait for the load balancer to be provisioned:

```sh
$ bash resources/test-lb.sh
```

2. Verify response from load balancer:

```sh
$ curl http://$(terraform output load-balancer-ip)
```

**Connecting with kubectl**

1. Get the cluster credentials and configure kubectl:

```sh
$ gcloud container clusters get-credentials $(terraform output cluster_name) --zone $(terraform output cluster_zone)
```

2. Verify kubectl connectivity:

```sh
$ kubectl get pods -n staging
```
