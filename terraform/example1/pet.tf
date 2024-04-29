resource "local_file" "pet" {
  content  = "cat"
  filename = "/tmp/pet.txt"
}