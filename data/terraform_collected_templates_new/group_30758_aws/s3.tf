resource "aws_s3_bucket" "alb_log" {
  bucket = "alb-log-igsr5"

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }
}

resource "aws_s3_bucket_policy" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.alb_log.json
}

data "aws_iam_policy_document" "alb_log" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.alb_log.id}/*"]

    principals {
      type        = "AWS"
      identifiers = ["582318560864"]
    }
  }
}

resource "aws_s3_bucket" "athena" {
  bucket = "athena-igsr5"
}

resource "aws_s3_bucket" "igsr5_images" {
  bucket = "igsr5-images"
}

resource "aws_s3_bucket_policy" "igsr5_images" {
  bucket = aws_s3_bucket.igsr5_images.id
  policy = data.aws_iam_policy_document.igsr5_images.json
}

data "aws_iam_policy_document" "igsr5_images" {
  statement {
    sid    = "Allow CloudFront"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.static-www.iam_arn]
    }
    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.igsr5_images.arn}/*"
    ]
  }
}
