# Azure Key Vault

Azure Key Vault security features.

## Deployment

Start by creating the temporary keys for SSH authentication:

```sh
mkdir .keys && ssh-keygen -f .keys/tmp_rsa
```

Copy the variables file:

```sh
cp config/local.auto.tfvars .auto.tfvars
```

Set the required values:

```terraform
subscription_id    = ""
allowed_public_ips = [""]
```

Create the infrastructure:

```sh
terraform init
terraform apply -auto-approve
```
