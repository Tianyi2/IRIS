resource "aws_autoscaling_group" "example" {
  availability_zones = data.aws_availability_zones.all.names
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size
  launch_template {
    id      = aws_launch_template.appx.id
    version = aws_launch_template.appx.latest_version
  }

  # launch_template { 
  #   name = aws_launch_template.example.name
  #   version = "$Latest"
  # }

  # mixed_instances_policy {
  #   launch_template {
  #     launch_template_specification {
  #       launch_template_id = aws_launch_template.example.id
  #       # version = aws_launch_template.example.latest_version
  #     }
  # override {
  #   instance_type     = "t2.micro"
  #   weighted_capacity = "3"
  # }
  # override {
  #   instance_type     = "t2.small"
  #   weighted_capacity = "2"
  # }
  #   }
  # }
}
