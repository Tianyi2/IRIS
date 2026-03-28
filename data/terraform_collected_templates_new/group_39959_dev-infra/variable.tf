variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {

}

variable "private_subnet_cidrs" {

}

variable "availability_zones" {
  type = list(string)
}

variable "public_route_cidr" {
  type = string
}

variable "vpc_id" {
  description = "The VPC ID where resources will be deployed"
  type        = string
}


variable "app_port" {
  description = "Port on which the application runs"
  type        = number
}

variable "ami_id" {
  description = "Custom AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "root_volume_size" {
  description = "Size of the root EBS volume"
  type        = number
  default     = 25
}

variable "root_volume_type" {
  description = "Type of the root EBS volume"
  type        = string
  default     = "gp2"
}

variable "SERVER_PORT" {
  description = "Application port"
  type        = number
  default     = 8000
}

variable "DB_NAME" {
  description = "Database name"
  type        = string
  default     = "healthdb"
}

variable "DB_USER" {
  description = "Database username"
  type        = string
  default     = "root"
}

variable "DB_PASSWORD" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "key_name" {
  type = string
}

variable "DB_LOGGING" {
  type    = bool
  default = false

}

variable "DB_DIALECT" {
  type    = string
  default = "mysql"
}

variable "DB_PORT" {
  type    = number
  default = 3306

}


variable "multi_az" {

}

variable "storage_type" {

}

variable "db_storage" {

}

variable "engine_version" {

}

variable "sse_algorithm" {

}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "domain_name" {
  type = string
}

variable "min-cpu" {}

variable "max-cpu" {}

variable "min-cpu-size" {
}

variable "max-cpu-size" {

}

variable "desired-capacity" {

}

variable "cooldown-period" {

}

variable "scaling-adjustment-down" {

}

variable "scaling-adjustment-up" {

}

variable "high-cpu-period" {

}

variable "low-cpu-period" {

}
variable "account_id" {

}

variable "cli_user" {
  type = string

}

variable "https-port" {

}