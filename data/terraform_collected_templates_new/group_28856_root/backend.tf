terraform {
  backend "s3" {
    bucket = "jenkins-emayan-master-1"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}