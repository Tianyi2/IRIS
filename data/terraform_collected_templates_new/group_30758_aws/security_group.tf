module "https_sg" {
  source      = "./modules/security_group"
  name        = "https-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 443
  cidr_blocks = ["0.0.0.0/0"]
}

module "mysql_sg" {
  source      = "./modules/security_group"
  name        = "mysql-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 3306
  cidr_blocks = [aws_vpc.igsr5.cidr_block]
}

module "http_sg" {
  source      = "./modules/security_group"
  name        = "http-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 80
  cidr_blocks = [aws_vpc.igsr5.cidr_block]
}

module "ssh_sg" {
  source      = "./modules/security_group"
  name        = "ssh-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 22
  cidr_blocks = [aws_vpc.igsr5.cidr_block]
}

module "time_management_slack_sg" {
  source      = "./modules/security_group"
  name        = "time-management-slack-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 3000
  cidr_blocks = ["0.0.0.0/0"]
}

module "vpc_endpoint_sg" {
  source      = "./modules/security_group"
  name        = "vpc-endpoint-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 443
  cidr_blocks = [aws_vpc.igsr5.cidr_block]
}

module "http_pub_sg" {
  source      = "./modules/security_group"
  name        = "http-pub-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 80
  cidr_blocks = ["0.0.0.0/0"]
}

module "ssh_pub_sg" {
  source      = "./modules/security_group"
  name        = "ssh-pub-sg"
  vpc_id      = aws_vpc.igsr5.id
  port        = 22
  cidr_blocks = ["0.0.0.0/0"]
}


