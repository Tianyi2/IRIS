resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "Csye-vpc-${var.aws_region}"
  }
}