// The instance is public to perform a SQL import and test CDC
resource "aws_db_instance" "postgres" {
  auto_minor_version_upgrade          = true
  db_subnet_group_name                = aws_db_subnet_group.rds_public.name
  deletion_protection                 = false
  engine                              = "postgres"
  engine_version                      = "15.8"
  iam_database_authentication_enabled = false
  identifier                          = "postgres"
  instance_class                      = local.postgres_db_instance
  parameter_group_name                = aws_db_parameter_group.postgres.name
  publicly_accessible                 = true
  username                            = var.postgres_user
  password                            = random_password.password.result
  vpc_security_group_ids              = [module.security_group_postgres.security_group_id]
  skip_final_snapshot                 = true
  storage_type                        = "gp3"
  allocated_storage                   = local.postgres_allocated_storage
  storage_throughput                  = local.postgres_storage_throughput
  iops                                = local.postgres_iops
  apply_immediately                   = true
}

resource "aws_db_parameter_group" "postgres" {
  description = "custom-postgres15"
  family      = "postgres15"
  name        = "custom-postgres15"

  parameter {
    apply_method = "immediate"
    name         = "wal_sender_timeout"
    value        = "0"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "max_wal_senders"
    value        = "35"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "rds.logical_replication"
    value        = "1"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "shared_preload_libraries"
    value        = "pg_stat_statements,pglogical"
  }
}

resource "aws_db_subnet_group" "rds_public" {
  name        = "rds-public"
  description = "RDS Subnet group"
  subnet_ids  = module.vpc.public_subnets
}

module "security_group_postgres" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name        = "postgres"
  description = "Security group for Postgres"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "internal"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "myip"
      cidr_blocks = "${chomp(data.http.myip.response_body)}/32"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

# Import using bulk COPY via aws_s3.table_import_from_s3
resource "null_resource" "postgres_import" {

  depends_on = [aws_db_instance_role_association.postgres]

  provisioner "local-exec" {
    interpreter = ["bash", "-c"]

    command = templatefile("${path.cwd}/resources/scripts/postgres_import.sh", {
      db_user      = var.postgres_user,
      db_name      = var.postgres_db,
      db_host      = element(split(":", aws_db_instance.postgres.endpoint), 0),
      tpch_db_size = var.tpch_db_size,
      max_parallel = local.postgres_max_parallel,
    })

    environment = {
      PGPASSWORD = nonsensitive(random_password.password.result)
    }
  }
}

# Required for the bulk COPY
resource "aws_db_instance_role_association" "postgres" {
  db_instance_identifier = aws_db_instance.postgres.identifier
  feature_name           = "s3Import"
  role_arn               = aws_iam_role.postgres.arn
}

resource "aws_iam_role_policy_attachment" "postgres" {
  role       = aws_iam_role.postgres.name
  policy_arn = aws_iam_policy.postgres.arn
}

resource "aws_iam_role" "postgres" {
  name = "postgres_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "rds.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "postgres" {
  name   = "postgres_policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::redshift-downloads",
                "arn:aws:s3:::redshift-downloads/*"
            ],
            "Effect": "Allow"
        }
    ]
}
EOF
}