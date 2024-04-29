## providers
providors are responsible for understanding API interactions and exposing resources.
- aws
- azure
- google cloud
- snowflake
- ...



muliple providers can be used in a single configuration file.
```terraform
resource "local_file" "pet_name" {
	    content = "We love pets!"
	    filename = "/root/pets.txt"
}


resource "random_pet" "my-pet" {
	      prefix = "Mrs"
	      separator = "."
	      length = "1"
}
```
when you run terrafom init, terraform will download the providers and plugins required for the configuration file.
