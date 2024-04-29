## purpose of terraform state

The Terraform state file is used to store the state of the infrastructure that is managed by Terraform. It contains information about the resources that have been created, updated, or destroyed by Terraform. The state file is used to keep track of the current state of the infrastructure and to determine what changes need to be made to reach the desired state.


Which location is the terraform state file stored by default?
inside configuration directory
Which option should we use to disable state?
we can't disable state
- it srored in json format
What is the name of the state file that is created by default? terraform.tfstate


```terraform
-- aws-infra
resource "aws_instance" "dev-server" {
    instance_type = "t2.micro"
    ami         = "ami-02cff456777cd"
}
resource "aws_s3_bucket" "falshpoint"  {
    bucket = "project-flashpoint-paradox"
}
```

```terraform
-- provider.tf
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  s3_use_path_style = true
  endpoints {
    ec2 = "http://aws:4566"
    iam = "http://aws:4566"
    s3 = "http://aws:4566"
    dynamodb = "http://aws:4566"
  }
}
```
Inspect the terraform.tfstate file or run terraform show command.

You will notice that all the attribute details for all the resources created by this configuration is now printed on the screen!


Among them is an EC2 Instance which is created by the resource called dev-server. See if you can find out the private_ip for the instance that was created.
```bash
terraform show
```