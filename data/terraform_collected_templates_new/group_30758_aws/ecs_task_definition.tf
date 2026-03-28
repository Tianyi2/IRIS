resource "aws_ecs_task_definition" "igsr5_time_management_slack" {
  family                   = "igsr5_time_management_slack"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./containers/time_management_slack_definitions.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
  lifecycle {
    ignore_changes = [container_definitions]
  }
}
