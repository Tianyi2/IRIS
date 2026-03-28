resource "aws_db_parameter_group" "mysql" {
  name        = "csye6225-mysql-params"
  family      = "mysql8.0"
  description = "Custom parameter group for MySQL"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }
  parameter {
    name  = "character_set_client"
    value = "utf8"
  }

  tags = {
    Name = "RDS-Security-group"
  }
}

resource "aws_db_subnet_group" "private" {
  name       = "private-subnet-group"
  subnet_ids = aws_subnet.private[*].id
}

resource "aws_db_instance" "mysql" {
  identifier             = "csye6225"
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.db_storage
  storage_type           = var.storage_type
  db_name                = var.DB_NAME
  username               = var.DB_USER
  password               = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["DB_PASSWORD"]
  parameter_group_name   = aws_db_parameter_group.mysql.name
  db_subnet_group_name   = aws_db_subnet_group.private.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  publicly_accessible    = false
  skip_final_snapshot    = true
  multi_az               = var.multi_az
  kms_key_id             = aws_kms_key.rds_key.arn
  storage_encrypted      = true
}