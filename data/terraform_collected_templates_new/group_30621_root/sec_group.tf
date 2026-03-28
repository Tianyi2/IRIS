resource "aws_security_group" "compA-sec-group" {
  name        = "asg-sec-group${var.app_name}"
  description = "Allow TLS inbound traffic from 80 and 443"
  ingress {
    description = "https from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-only-ingress"
  }
}
