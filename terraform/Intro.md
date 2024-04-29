
traditional way before infrastructure as code:
- manual process
- error-prone
- time-consuming
- difficult to scale
- difficult to maintain
- difficult to reproduce

infrastructure as code  is a way to automate the process of managing and provisioning infrastructure.

terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.

terraform features:
- Infrastructure as Code 
- Execution Plans
- Resource Graph
- Change Automation

**infra as code**: terraform configuration files describe to the terraform engine how to build the infrastructure.
**execution plans**: terraform generates an execution plan describing what it will do to reach the desired state.
**resource graph**: terraform builds a graph of all your resources, and parallelizes the creation and destruction of non-dependent resources.
**change automation**: complex changesets can be applied to your infrastructure with minimal human interaction


## example1
- create a file called pet.tf in local directory
```terraform
resource "local_file" "pet" {
  content  = "cat"
  filename = "/tmp/pet.txt"
}
```
block name : resource
resource type : local_file
provider : local
resource name : pet
type : file
attribute : content = "cat" & filename = "/tmp/pet.txt"

- create ec2 instance
```terraform
provider "aws" {
  region = "us-west-2"
}
resource "aws_instance" "webserver" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
```
- create s3 bucket
```terraform
provider "aws" {
  region = "us-west-2"
}
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-tf-test-bucket"
  acl    = "private"
}
```

## basic commands
terraform init : initialize a working directory containing Terraform configuration files
terraform plan : generate and show an execution plan
terraform apply : apply the changes required to reach the desired state of the configuration