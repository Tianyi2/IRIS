output "postgres_host" {
  value = element(split(":", aws_db_instance.postgres.endpoint), 0)
}