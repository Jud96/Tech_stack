### Data sources

Data sources are used to fetch information from external sources and use it in the Terraform configuration. They allow you to reference information that is not managed by Terraform.
```terraform
output "os-version" {
  value = data.local_file.os.content
}
data "local_file" "os" {
  filename = "/etc/os-release"
}
```

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
-- s3.tf
data "aws_s3_bucket" "bucket" {
  bucket = "my-tf-test-bucket"
}
```