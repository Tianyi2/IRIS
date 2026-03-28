// resource "aws_db_parameter_group" "igsr5_sandbox" {
//   name   = "igsr5-sandbox"
//   family = "mysql5.7"
// 
//   parameter {
//     name  = "character_set_database"
//     value = "utf8mb4"
//   }
// 
//   parameter {
//     name  = "character_set_server"
//     value = "utf8mb4"
//   }
// 
//   parameter {
//     name  = "slow_query_log"
//     value = 1
//   }
// 
//   parameter {
//     name  = "general_log"
//     value = 1
//   }
// 
//   parameter {
//     name  = "long_query_time"
//     value = 5
//   }
// }
// 
// resource "aws_db_option_group" "igsr5_sandbox" {
//   name                 = "igsr5-sandbox"
//   engine_name          = "mysql"
//   major_engine_version = "5.7"
// 
//   option {
//     option_name = "MARIADB_AUDIT_PLUGIN"
//   }
// }
// 
// resource "aws_db_subnet_group" "igsr5" {
//   name       = "igsr5"
//   subnet_ids = [aws_subnet.igsr5_private_0.id, aws_subnet.igsr5_private_1.id]
// }
// 
// resource "aws_db_instance" "igsr5_sandbox" {
//   identifier                 = "igsr5-sandbox"
//   engine                     = "mysql"
//   engine_version             = "5.7"
//   instance_class             = "db.t2.micro"
//   allocated_storage          = 20
//   max_allocated_storage      = 100
//   storage_type               = "gp2"
//   storage_encrypted          = false
//   username                   = "admin"
//   password                   = "uninitialized"
//   multi_az                   = false
//   publicly_accessible        = false
//   backup_window              = "09:10-09:40"
//   backup_retention_period    = 30
//   maintenance_window         = "mon:10:10-mon:10:40"
//   auto_minor_version_upgrade = false
//   deletion_protection        = false
//   skip_final_snapshot        = true
//   port                       = 3306
//   apply_immediately          = false
//   enabled_cloudwatch_logs_exports = [
//     "error",
//     "general",
//     "slowquery"
//   ]
//   vpc_security_group_ids = [module.mysql_sg.security_group_id]
//   parameter_group_name   = aws_db_parameter_group.igsr5_sandbox.name
//   option_group_name      = aws_db_option_group.igsr5_sandbox.name
//   db_subnet_group_name   = aws_db_subnet_group.igsr5.name
// 
//   lifecycle {
//     ignore_changes = [password, latest_restorable_time]
//   }
// }
