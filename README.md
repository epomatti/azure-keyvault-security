# Azure Key Vault

Azure Key Vault security features.

> [!NOTE]
> Virtual Machine encryption options are implemented in [this](https://github.com/epomatti/azure-linux-security) repository.

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
subscription_id            = ""
public_ip_address_to_allow = [""]
```

Create the infrastructure:

```sh
terraform init
terraform apply -auto-approve
```

## VM Identity Operations

Login to the CLI:

```sh
az login --identity
```

List keys:

```sh
az keyvault secret list --vault-name $kvn
```

Show a secret value:

```sh
az keyvault secret show --vault-name $kvn --name ApplicationSecret --query value
```
