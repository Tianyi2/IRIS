resource "aws_elb" "bar" {
  name               = "foobar-terraform-elbs"
  availability_zones = data.aws_availability_zones.all.names
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  # need to add ssl_certificate_id
  # listener {
  # instance_port     = 443
  # instance_protocol = "https"
  # lb_port           = 443
  # lb_protocol       = "https"
  # ssl_certificate_id = "arn:aws:iam::000000000000:server-certificate/wu-tang.net"
  # }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "foobar-terraform-elbs"
  }
}


resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.example.id
  elb                    = aws_elb.bar.id
}