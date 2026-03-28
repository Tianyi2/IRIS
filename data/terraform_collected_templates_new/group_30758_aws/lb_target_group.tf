# -- example --
# resource "aws_lb_target_group" "igsr5_sandbox_muson" {
#   name                 = "igsr5-sandbox-muson"
#   target_type          = "ip"
#   vpc_id               = aws_vpc.igsr5.id
#   port                 = 80
#   protocol             = "HTTP"
#   deregistration_delay = 300
# 
#   health_check {
#     path                = "/service"
#     healthy_threshold   = 5
#     unhealthy_threshold = 2
#     timeout             = 5
#     interval            = 300
#     matcher             = 200
#     port                = 80
#     protocol            = "HTTP"
#   }
#   depends_on = [aws_lb.igsr5]
# }
