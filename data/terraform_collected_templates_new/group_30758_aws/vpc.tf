/*
 * vpc
 * */
resource "aws_vpc" "igsr5" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "igsr5"
  }
}

/*
 * public subnet
 * */
resource "aws_subnet" "igsr5_public_0" {
  vpc_id                  = aws_vpc.igsr5.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name = "igsr5_public_0"
  }
}

resource "aws_subnet" "igsr5_public_1" {
  vpc_id                  = aws_vpc.igsr5.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1c"

  tags = {
    Name = "igsr5_public_1"
  }
}

/*
 * private subnet
 * */
resource "aws_subnet" "igsr5_private_0" {
  vpc_id                  = aws_vpc.igsr5.id
  cidr_block              = "10.0.65.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "igsr5_private_0"
  }
}

resource "aws_subnet" "igsr5_private_1" {
  vpc_id                  = aws_vpc.igsr5.id
  cidr_block              = "10.0.66.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false

  tags = {
    Name = "igsr5_private_1"
  }
}

/*
 * internet gateway
 * */
resource "aws_internet_gateway" "igsr5" {
  vpc_id = aws_vpc.igsr5.id

  tags = {
    Name = "igsr5"
  }
}

/*
 * nat gateway
 * */
// resource "aws_nat_gateway" "igsr5" {
//   allocation_id = aws_eip.nat_gateway.id
//   subnet_id     = aws_subnet.igsr5_public_0.id
//   depends_on    = [aws_internet_gateway.igsr5]
// 
//   tags = {
//     Name = "igsr5"
//   }
// }
