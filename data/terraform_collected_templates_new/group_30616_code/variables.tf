variable "email" {
  default     = ""
  description = "Email where to send the SNS notifications when the jobs fail"
  validation {
    condition     = length(var.email) > 0
    error_message = "The email value cannot be empty."
  }
}

variable "project_name" {
  default     = "datalake-demo"
  description = "Used for tagging"
}

variable "region" {
  default = "eu-west-1"
}

variable "tpch_db_size" {
  default     = "10GB"
  description = "TCH database size to use"
  validation {
    condition     = can(regex("^(10GB|100GB|3TB|10TB)$", var.tpch_db_size))
    error_message = "The TCH database size to use must be 10GB, 100GB, 3TB or 10TB"
  }
}

variable "postgres_db" {
  default = "postgres"
}

variable "postgres_user" {
  default = "postgres"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}