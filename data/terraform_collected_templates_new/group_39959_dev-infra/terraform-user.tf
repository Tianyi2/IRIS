# resource "aws_iam_policy" "extended_secrets_access" {
#   name        = "SecretsPolicy"
#   description = "Permissions required to execute Terraform configurations"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         "Effect" : "Allow",
#         "Action" : [
#           "secretsmanager:GetSecretValue",
#           "secretsmanager:DescribeSecret",
#           "kms:Decrypt",
#           "rds:DescribeDBInstances",
#           "ec2:DescribeInstances"
#         ],
#         "Resource" : "*"
#       },
#       {
#         Effect   = "Allow",
#         Action   = "sts:AssumeRole",
#         Resource = "*"
#       }
#     ]
#   })
# }