resource "local_file" "pet" {
  content  = "cat"
  filename = "/tmp/pet.txt"
  file_permission = "0700"
}