## Terraform commands

| Command | Description |
| --- | --- |
| terraform init | Initialize a Terraform working directory |
| terraform plan | Generate and show an execution plan |
| terraform apply | Apply the changes required to reach the desired state of the configuration |
| terraform destroy | Destroy the Terraform-managed infrastructure |
| terraform show | Show the current state |
| terraform output | Show the output values of the Terraform configuration |
| terraform validate | Validate the Terraform files |
| terraform fmt | Rewrites Terraform configuration files to a canonical format |
| terraform providers | Show the providers required for this configuration |
| terraform version | Show the current Terraform version |
| terraform graph | Create a visual graph of Terraform resources |
| terraform refresh | Update the state file according to the real-world infrastructure |

### mutable and immutable infrastructure
mutable infrastructure is the traditional way of managing infrastructure. In this approach, the infrastructure is updated in place. This means that changes are made directly to the existing infrastructure.

**immutable infrastructure** is a modern approach to managing infrastructure. In this approach, changes are made by replacing the existing infrastructure with a new one. This ensures that the infrastructure is always in a known good state.