# AWS Infrastructure

**Authentication**

- Credentials on file: used for local deployment

Terraform variable to credentials filepath:

~~~
variable "credentials" {
  description = "Service account credentials"
  default     = "./secrets/creds"
}
~~~

`creds` file:

~~~
[develop]
aws_access_key_id = changeme
aws_secret_access_key = changeme
~~~

`provider.tf`:

~~~
provider "aws" {
  region                  = var.region
  shared_credentials_file = var.credentials
  profile                 = var.profile # develop
}
~~~

- Credentials as environment variable: used for local deployment nor Terraform Cloud

~~~
AWS_ACCESS_KEY_ID=changeme
AWS_SECRET_ACCESS_KEY=changeme
~~~
