# GCP Infrastructure

**Authentication for Google provider**

Download the `.json` authentication file and set the following terraform variable:

```tf
variable "credentials" {
  description = "Service account credentials in json format"
  default     = "./keys/gcp_creds.json"
}
```

```json
gcp_creds.json
{
  "type": "service_account",
  "project_id": "",
  "private_key_id": "",
  "private_key": "",
  "client_email": "",
  "client_id": "",
  "auth_uri": "",
  "token_uri": "",
  "auth_provider_x509_cert_url": "",
  "client_x509_cert_url": ""
}
```

For Terraform Cloud you have to configure the `.json` as `GOOGLE_CREDENTIALS` environment variable (all in one line).

## References

**Terraform google provider**

[Google Cloud Platform Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)

[google_compute_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#image)

[google_compute_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network)

[google_compute_firewall](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)

[google_compute_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address)
