// NOTE: 最近あまり使っていないので止める
// resource "aws_ecs_service" "igsr5_time_management_slack" {
//   name             = "igsr5_time_management_slack"
//   cluster          = aws_ecs_cluster.igsr5.arn
//   task_definition  = aws_ecs_task_definition.igsr5_time_management_slack.arn
//   desired_count    = 1
//   launch_type      = "FARGATE"
//   platform_version = "1.4.0"
//   // health_check_grace_period_seconds = 600
// 
//   network_configuration {
//     assign_public_ip = true
//     security_groups  = [module.time_management_slack_sg.security_group_id]
//     // subnets = [
//     //   aws_subnet.igsr5_private_0.id,
//     //   aws_subnet.igsr5_private_1.id,
//     // ]
//     subnets = [
//       aws_subnet.igsr5_public_0.id,
//       aws_subnet.igsr5_public_1.id,
//     ]
//   }
// 
//   // load_balancer {
//   //   target_group_arn = aws_lb_target_group.igsr5_time_management_slack.arn
//   //   container_name   = "igsr5_time_management_bolt"
//   //   container_port   = 80
//   // }
//   // lifecycle {
//   //  ignore_changes = [task_definition]
//   // }
// }
