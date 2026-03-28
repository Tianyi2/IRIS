# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.igsr5.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   certificate_arn   = aws_acm_certificate.igsr5.arn
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
# 
#   default_action {
#     type = "fixed-response"
# 
#     fixed_response {
#       content_type = "text/plain"
#       message_body = "this is https."
#       status_code  = "200"
#     }
#   }
# }
