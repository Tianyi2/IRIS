data "aws_ami" "image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["*1116-apache-web-server-with-centos-7-6*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"] # Canonical
}

data "aws_availability_zones" "all" {}
output "AZ" {
  value = data.aws_availability_zones.all.names
}

