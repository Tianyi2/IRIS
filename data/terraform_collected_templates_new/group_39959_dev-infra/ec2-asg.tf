resource "aws_launch_template" "asg_launch_template" {
  name_prefix   = "csye6225_asg_"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.app_sg.id]
  }


  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      delete_on_termination = true
      volume_size           = 8
      volume_type           = var.storage_type
      encrypted             = true
      kms_key_id            = aws_kms_key.ec2_key.arn
    }
  }


  user_data = base64encode(templatefile("${path.module}/userdata.sh", {
    secret_name    = aws_secretsmanager_secret.db_password_secret.name
    DB_NAME        = var.DB_NAME
    DB_HOST        = "${aws_db_instance.mysql.address}"
    DB_PORT        = 3306
    S3_BUCKET_NAME = "${aws_s3_bucket.s3_bucket.bucket}"
    DB_DIALECT     = var.DB_DIALECT
    SERVER_PORT    = var.SERVER_PORT
    DB_USER        = var.DB_USER
    AWS_REGION     = var.aws_region

  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.aws_region}-asg-instance"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}