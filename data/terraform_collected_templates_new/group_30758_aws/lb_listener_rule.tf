# resource "aws_lb_listener_rule" "igsr5_sandbox_muson" {
#   listener_arn = aws_lb_listener.https.arn
#   priority     = 100
# 
#   action {
#     type = "redirect"
# 
#     redirect {
#       port        = "443"
#       host        = "sandbox.muson.co.jp"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# 
#   condition {
#     host_header {
#       values = ["sandbox_muson.igsr5.com"]
#     }
#   }
# }
