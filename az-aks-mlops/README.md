# Deploy AKS for MlOps project

## Usage

Just a few commands. Consider using properly based on your setup.

```sh
$ pulumi new azure-python

$ az account list-locations --output table

$ pulumi config set azure-native:location eastus

$ pulumi up
$ pulumi logout && pulumi login

$ pulumi config set aks-mlops:prefix mlops
$ pulumi config set --secret aks-mlops:password changeme
$ cat $HOME/.ssh/id_rsa.pub | pulumi config set aks-mlops:sshkey
$ pulumi config set aks-mlops:location WestUS
```
