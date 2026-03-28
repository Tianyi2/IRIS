// resource "aws_lb" "igsr5" {
//   name                       = "igsr5"
//   load_balancer_type         = "application"
//   internal                   = false
//   idle_timeout               = 3600
//   enable_deletion_protection = true
// 
//   subnets = [
//     aws_subnet.igsr5_public_0.id,
//     aws_subnet.igsr5_public_1.id,
//   ]
// 
//   access_logs {
//     bucket  = aws_s3_bucket.alb_log.id
//     enabled = true
//   }
// 
//   security_groups = [
//     module.https_sg.security_group_id,
//   ]
// }
