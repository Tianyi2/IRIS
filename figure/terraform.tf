variable "environment" {
  type = string
  validation {
    condition = contains(["dev", "prod"],
                         var.environment)
    error_message = "Must be dev or prod."
  }
}
variable "backup_retention" {               # SMELL 1
  type    = number
  default = 7
}
resource "aws_security_group" "db" {
  name        = "db-access"
  description = "Database access"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]             # SMELL 2
  }
}
resource "aws_db_instance" "database" {
  count          = var.environment == "prod" ? 1 : 0
  engine         = "mysql"
  instance_class = "db.t3.micro"
  username       = "admin"
  password       = "Admin123!"              # SMELL 3
  vpc_security_group_ids = [
    aws_security_group.db.id]
}
resource "aws_cloudwatch_metric_alarm" "db_cpu" {
  alarm_name  = "db-high-cpu"               # SMELL 4
  namespace   = "AWS/RDS"
  metric_name = "CPUUtilization"
  dimensions  = {
    DBInstanceIdentifier = aws_db_instance.database[0].id
  }
  comparison_operator = "GreaterThanThreshold"
  threshold           = 80
  evaluation_periods  = 2
  period              = 300
  statistic           = "Average"
}
