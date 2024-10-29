## Terraform
1. infrastructure as code  is a way to automate the process of managing and provisioning infrastructure 
   1. advantages don't use UI ,repeatable, scalable, versionable, testable, shareable, and collaborative
2. terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.
3. execution plans describe what it will do to reach the desired state.
4. resource graph builds a graph of all your resources, and parallelizes the creation and destruction of non-dependent resources.
5. change automation: complex changesets can be applied to your infrastructure with minimal human interaction
6. providers are responsible for understanding API interactions and exposing resources like aws, azure, google cloud, snowflake, etc.
7. input variables are parameters for a Terraform module and are defined in a module block
8. using variables
    - Environment variables 
    - terraform.tfvars or terraform.tfvars.json
    - *.auto.tfvars or *.auto.tfvars.json
    - Command line flags
    - for prirority, the last value assigned to a variable will be used. first, terraform will look for the variable in the command line flags, then in the *.auto.tfvars or *.auto.tfvars.json files, then in the terraform.tfvars or terraform.tfvars.json files, and finally in the environment variables. so the environment variables have the lowest priority.
9.  resoures attributes are the properties of a resource that can be configured.
10. resources dependecies are the relationships between resources that are used to determine the order in which resources are created, updated, and destroyed.
    1.  explicit dependencies are defined using the depends_on meta-argument
    2.  implicit dependencies are defined by referencing the attributes of one resource in another resource.
11. output variables are the return values of a Terraform module and are defined in an output block.
12. immutable infrastructure is a modern approach to managing infrastructure. In this approach, changes are made by replacing the existing infrastructure with a new one. This ensures that the infrastructure is always in a known good state.
13. terraform lifecycle rules are used to control the behavior of resources during the apply and destroy phases. They can be used to prevent certain actions from being taken on a resource, or to control when a resource is created, updated, or destroyed.
    1. create_before_destroy: Create a new resource before destroying the old one
    2. prevent_destroy: Prevent a resource from being destroyed
    3. ignore_changes: Ignore changes to specific attributes of a resource
14. Data sources are used to fetch information from external sources and use it in the Terraform configuration. They allow you to reference information that is not managed by Terraform. 
15. count and for_each are used to create multiple instances of a resource. count is used when you want to create a fixed number of instances, while for_each is used when you want to create instances based on a map or set of values.


## How to

**Create a file called pet.tf in local directory**
```terraform
resource "local_file" "pet" {
  content  = "cat"
  filename = "/tmp/pet.txt"
}
```

**change file permissions**
```bash
resource "local_file" "pet" {
  content  = "cat"
  filename = "/tmp/pet.txt"
  file_permission = "0777"
}
```
it will destroy and recreate the file with the new permissions

**create ec2 instance**
```terraform
provider "aws" {
  region = "us-west-2"
}
resource "aws_instance" "webserver" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
```

**create s3 bucket**
```terraform
provider "aws" {
  region = "us-west-2"
}
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-tf-test-bucket"
  acl    = "private"
}
```

** define input variables in different ways**
```terraform
-- main.tf
resource local_file games {
  filename = var.filename
  content = "football"
}
```
```terraform
-- terraform.tfvars
filename = "/root/football.txt"
```

```terraform
-- basketball.auto.tfvars
filename = "/root/basketball.txt"
```

```terraform
-- throw.auto.tfvars
filename = "/root/baseball.txt"
```
```terraform
# variables.tf
variable "filename" {
  type = string
}
```
**explicit dependencies**
```terraform
resource "local_file" "whale" {
  filename   = "/root/whale"
  content    = "whale"
  depends_on = [local_file.krill]
}
resource "local_file" "krill" {
  filename = "/root/krill"
  content  = "krill"
}
```
**implicit dependencies**
```terraform
resource "aws_instance" "web" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

resource "aws_eip" "ip" {
  instance = aws_instance.web.id
}
```

**create before destroy**
```terraform
resource "local_file" "file" {
    filename = var.filename
    file_permission =  var.permission
    content = random_string.string.id
    lifecycle {
        create_before_destroy =  true
    }
}
```
**prevent destroy**
```terraform
resource "random_pet" "super_pet" {
    length = var.length
    prefix = var.prefix
    lifecycle {
      prevent_destroy = true
    }
}
```

**data sources**
```terraform
data "aws_ebs_volume" "gp2_volume" {
  most_recent = true

  filter {
    name   = "volume-type"
    values = ["gp2"]
  }
}
```
```terraform
data "local_file" "os" {
  filename = "/etc/os-release"
}
```
```terraform
data "aws_s3_bucket" "bucket" {
  bucket = "my-tf-test-bucket"
}
```

next resources to learn:

git clone https://github.com/hashicorp/learn-terraform-aws-asg.git
git clone https://github.com/hashicorp/learn-terraform-rds-upgrade.git
git clone https://github.com/hashicorp/learn-terraform-iam-policy.git