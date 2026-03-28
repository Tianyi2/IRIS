resource "aws_ecr_repository" "igsr5" {
  name = "igsr5"
}

resource "aws_ecr_lifecycle_policy" "igsr5" {
  repository = aws_ecr_repository.igsr5.name

  policy = <<EOF
  {
    "rules": [
      {
        "rulePriority": 1,
        "description": "Keep last 30 release tagged images",
        "selection": {
          "tagStatus": "tagged",
          "tagPrefixList": ["release"],
          "countType": "imageCountMoreThan",
          "countNumber": 30
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  }
  EOF
}
