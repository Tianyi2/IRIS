resource "aws_iam_instance_profile" "appx_profile" {
  name = "test_profile"
  role = aws_iam_role.aapx_role.name
}

resource "aws_iam_role" "aapx_role" {
  name = "aapx_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}