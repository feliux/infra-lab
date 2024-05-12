### Building and pentesting a vulnerable infrastructure.

First, consider to generate a ssh keys on a new folder:

```sh
$ mkdir keys
$ ssh-keygen -f keys/aws_key -t rsa -b 4096
```

Then you have 3 options:

1. Deploy with TerraformCloud. In this case you have to configure in TerraformCloud the `ssh_public_key"` from `variables.tf`.
2. Deploy from local. Uncomment one of the below variables present in `variables.tf`. Comment the `ssh_public_key` variables block.

```go
ssh_key_path     = "keys/aws_key.pub"
ssh_key_base64   = "changeme" // base64 ssh public key
```

Also, you have to uncomment the corresponfing resource in `ec2.tf`

```go
resource "aws_key_pair" "ssh_key" {
  key_name = var.ubuntu_server.ssh_key_name
  // public_key = file(var.ubuntu_server.ssh_key_path)
  // public_key = base64decode(var.ubuntu_server.ssh_key_base64)
  public_key = base64decode(var.ssh_public_key)
  tags = {
    terraform = true
  }
}
```

3. Yo can deploy on TerraformCloud setting the the `ssh_key_base6` variable in any case.

## Vulnerabilities

Vulnerabilities present on machine.

- LFI
