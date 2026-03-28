resource "aws_autoscaling_group" "web_app_asg" {
  name                = "csye6225_asg"
  min_size            = var.min-cpu-size
  max_size            = var.max-cpu-size
  desired_capacity    = var.desired-capacity
  health_check_type   = "ELB"
  vpc_zone_identifier = aws_subnet.public[*].id
  target_group_arns   = [aws_lb_target_group.web_app_tg.arn]

  launch_template {
    id      = aws_launch_template.asg_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "web-app-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  scaling_adjustment     = var.scaling-adjustment-up
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.cooldown-period
  autoscaling_group_name = aws_autoscaling_group.web_app_asg.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down"
  scaling_adjustment     = var.scaling-adjustment-down
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.cooldown-period
  autoscaling_group_name = aws_autoscaling_group.web_app_asg.name
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.high-cpu-period
  statistic           = "Average"
  threshold           = var.max-cpu
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
  dimensions          = { AutoScalingGroupName = aws_autoscaling_group.web_app_asg.name }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "low-cpu-utilization"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.low-cpu-period
  statistic           = "Average"
  threshold           = var.min-cpu
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
  dimensions          = { AutoScalingGroupName = aws_autoscaling_group.web_app_asg.name }
}