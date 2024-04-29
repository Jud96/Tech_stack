## terraform lifecycle rules
Terraform lifecycle rules are used to control the behavior of resources during the apply and destroy phases. They can be used to prevent certain actions from being taken on a resource, or to control when a resource is created, updated, or destroyed.

| Rule | Description |
| --- | --- |
| create_before_destroy | Create a new resource before destroying the old one |
| prevent_destroy | Prevent a resource from being destroyed |
| ignore_changes | Ignore changes to specific attributes of a resource |

```terraform
variable "length" {
    default = 10
  
}
variable "filename" {
    default = "/root/random_text"
}
variable "content" {
    default = "This file contains a single line of data"
}
variable "permission" {
    default = 0700
}

```
```terraform
resource "local_file" "file" {
    filename = var.filename
    file_permission =  var.permission
    content = random_string.string.id
    
}

resource "random_string" "string" {
    length = var.length
    keepers = {
        length = var.length
    }  
    
}


```

Let's change the order in which the resource called string is recreated. Update the configuration so that when applied, a new random string is created first before the old one is destroyed.

```terraform
resource "local_file" "file" {
    filename = var.filename
    file_permission =  var.permission
    content = random_string.string.id
    lifecycle {
        create_before_destroy =  true
    }
}

resource "random_string" "string" {
    length = var.length
    keepers = {
        length = var.length
    }  
    lifecycle {
        create_before_destroy =  true
    }

}
```

update the configuration so that the resource super_pet is not destroyed under any circumstances with a terraform destroy or terraform apply command.


```terraform
resource "random_pet" "super_pet" {
    length = var.length
    prefix = var.prefix
   
}
```

```terraform

resource "random_pet" "super_pet" {
    length = var.length
    prefix = var.prefix
    lifecycle {
      prevent_destroy = true
    }
}
```