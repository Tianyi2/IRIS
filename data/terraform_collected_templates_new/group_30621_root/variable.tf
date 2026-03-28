variable "aws_region" {}
variable "desired_capacity" {}
variable "max_size" {}
variable "min_size" {}
variable "key_name" {}
variable "key_location" {}
variable "app_name" {}
variable "users3" {}
variable "bucketname" {}
variable "ssh_cidr_blocks" {
  type = list(any)
}
variable "security_group_ids" {
  description = "A list of associated security group IDs"
  type        = list(string)
  default     = []
}
