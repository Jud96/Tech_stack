## using variables

you can define input variables in different ways:


- Environment variables 
- terraform.tfvars or terraform.tfvars.json
- *.auto.tfvars or *.auto.tfvars.json
- Command line flags

for prirority, the last value assigned to a variable will be used. first, terraform will look for the variable in the command line flags, then in the *.auto.tfvars or *.auto.tfvars.json files, then in the terraform.tfvars or terraform.tfvars.json files, and finally in the environment variables. so the environment variables have the lowest priority.

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

The terraform plan command did not run as there was no reference for the input variable called filename in the configuration files.

```
# variables.tf
variable "filename" {
  type = string
}
```