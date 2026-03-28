# variables.tf (Input Variables)

# This file defines all the input variables for the Terraform project.
# These can be set when you run `terraform apply`.

variable "riot_api_key" {
  type        = string
  description = "The API key for the Riot Games API."
  sensitive   = true
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket for the data lake."
  default     = "gg-analyzer-data-younis"
}