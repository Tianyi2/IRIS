resource "aws_security_group" "db" {
  ingress {
    cidr_blocks = ["0.0.0.0/0"]             # SMELL 1
  }
}
resource "aws_db_instance" "database" {
  count = var.environment == "prod" ? 1 : 0
}
resource "aws_cloudwatch_metric_alarm" "db_cpu" { # SMELL 2
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.database[0].id
  }
}