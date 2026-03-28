module "database_migration_service" {
  source  = "terraform-aws-modules/dms/aws"
  version = "2.3.0"

  # Wait until the DB import is completed
  depends_on = [null_resource.postgres_import]

  # Subnet group
  repl_subnet_group_name        = "dms-private"
  repl_subnet_group_description = "DMS Subnet group"
  repl_subnet_group_subnet_ids  = module.vpc.private_subnets

  # Controls if it is serverless or provisioned
  create_repl_instance = false

  # Only applicable for provisioned
  repl_instance_allocated_storage           = 100
  repl_instance_auto_minor_version_upgrade  = true
  repl_instance_allow_major_version_upgrade = false
  repl_instance_apply_immediately           = true
  repl_instance_engine_version              = "3.5.2"
  repl_instance_multi_az                    = false
  repl_instance_publicly_accessible         = false
  repl_instance_class                       = local.dms_instance
  repl_instance_id                          = "instance"
  repl_instance_vpc_security_group_ids      = [module.security_group_postgres.security_group_id]

  # Access role
  create_access_iam_role = true
  access_iam_role_name   = "dms"
  access_secret_arns = [
    module.secrets_manager_postgres.secret_arn
  ]
  access_target_s3_bucket_arns = [
    module.s3_bucket["raw_bucket"].s3_bucket_arn,
    "${module.s3_bucket["raw_bucket"].s3_bucket_arn}/*"
  ]

  s3_endpoints = {
    s3-target = {
      endpoint_id   = "s3-target"
      endpoint_type = "target"
      engine_name   = "s3"

      bucket_folder                               = local.raw_bucket_prefix
      bucket_name                                 = module.s3_bucket["raw_bucket"].s3_bucket_id
      data_format                                 = "parquet"
      ssl_mode                                    = "none"
      encryption_mode                             = "SSE_S3"
      add_column_name                             = true
      timestamp_column_name                       = "last_update_time"
      include_op_for_full_load                    = true
      use_task_start_time_for_full_load_timestamp = true
    }
  }

  endpoints = {
    postgres-source = {
      database_name               = var.postgres_db
      endpoint_id                 = "postgres-source"
      endpoint_type               = "source"
      engine_name                 = "postgres"
      ssl_mode                    = "require"
      extra_connection_attributes = "heartbeatFrequency=1;secretsManagerEndpointOverride=${module.vpc_endpoints.endpoints["secretsmanager"]["dns_entry"][0]["dns_name"]}"

      secrets_manager_arn             = module.secrets_manager_postgres.secret_arn
      secrets_manager_access_role_arn = module.database_migration_service.access_iam_role_arn

      # Disable capturing DDL changes since the Glue job cannot handle this
      postgres_settings = {
        capture_ddls        = false
        heartbeat_enable    = true
        heartbeat_frequency = 1
      }
    }
  }

  replication_tasks = {
    postgres_s3 = {
      replication_task_id       = "postgres-to-s3"
      migration_type            = "full-load-and-cdc"
      replication_task_settings = file("resources/configs/dms_task_settings.json")
      table_mappings            = file("resources/configs/dms_table_mappings.json")
      source_endpoint_key       = "postgres-source"
      target_endpoint_key       = "s3-target"
      start_replication_task    = true

      # Only applicable to serverless
      # Set to a high value (64 x 2GB = 128MB RAM) to handle any of the database sizes
      serverless_config = {
        max_capacity_units     = 64
        min_capacity_units     = 1
        multi_az               = false
        vpc_security_group_ids = [module.security_group_postgres.security_group_id]
      }
    }
  }
}