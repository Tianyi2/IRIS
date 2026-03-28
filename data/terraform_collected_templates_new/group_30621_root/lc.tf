resource "aws_launch_template" "appx" {
  name_prefix   = "example"
  image_id      = data.aws_ami.image.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.asg-key-pair.key_name
  # security_group_names = ["aws_security_group.compA-sec-group.name"]
  iam_instance_profile {
    name = aws_iam_instance_profile.appx_profile.name
  }



  # network_interfaces {
  #   associate_public_ip_address = true
  #   security_groups = ["aws_security_group.compA-sec-group.name"]
  #   delete_on_termination       = true
  # } 

  # }

}
