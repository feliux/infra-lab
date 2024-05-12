Building and pentesting a vulnerable infrastructure.

First, consider to generate a ssh keys on a new folder if you want to specify `ssh_key_path` on `variables.tf`

```sh
$ mkdir keys
$ ssh-keygen -f keys/aws_key -t rsa -b 4096
```

## Vulnerabilities

Vulnerabilities present on machine.

- LFI
