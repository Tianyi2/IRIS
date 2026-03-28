# Create random password
resource "random_password" "vm_password" {
  length  = 20
  special = true
}