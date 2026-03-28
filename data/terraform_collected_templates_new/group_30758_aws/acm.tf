resource "aws_acm_certificate" "igsr5" {
  domain_name               = data.aws_route53_zone.igsr5.name
  subject_alternative_names = [format("*.%s", data.aws_route53_zone.igsr5.name)]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "igsr5" {
  certificate_arn         = aws_acm_certificate.igsr5.arn
  validation_record_fqdns = [aws_route53_record.igsr5_certificate.fqdn]
}

