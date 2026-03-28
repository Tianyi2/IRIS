# resource "aws_instance" "csye6225_ec2_instance" {
#   ami                    = var.ami_id
#   instance_type          = var.instance_type
#   subnet_id              = aws_subnet.public[0].id
#   vpc_security_group_ids = [aws_security_group.app_sg.id]
#   iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
#   key_name               = var.key_name

#   root_block_device {
#     volume_size           = 25
#     volume_type           = "gp2"
#     delete_on_termination = true
#   }

#   depends_on = [aws_db_instance.mysql]

#   user_data = <<-EOT
# #!/bin/bash

# echo "hello!"

# cat <<EOF | sudo tee /opt/webapp/.env
# DB_HOST=${aws_db_instance.mysql.address}
# DB_PORT=3306
# DB_USER=${var.DB_USER}
# DB_PASSWORD=${var.DB_PASSWORD}
# DB_NAME=${var.DB_NAME}
# SERVER_PORT=${var.SERVER_PORT}
# DB_DIALECT=${var.DB_DIALECT}
# S3_BUCKET_NAME=${aws_s3_bucket.s3_bucket.bucket}
# AWS_REGION=${var.aws_region}
# DB_LOGGING=false
# EOF
# sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/cloudWatch-config.json -s
# EOT

#   tags = {
#     Name = "${var.aws_region}-ec2-instance"
#   }
# }