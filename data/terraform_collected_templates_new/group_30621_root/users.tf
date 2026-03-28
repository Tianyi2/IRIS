resource "aws_iam_user" "userid12" {
  name = var.users3
  tags = {
    CreatedBy = "Team"
  }
}