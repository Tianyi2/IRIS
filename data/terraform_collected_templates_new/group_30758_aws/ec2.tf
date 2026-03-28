resource "aws_key_pair" "igsr5_debug_server_key_pair" {
  key_name   = "igsr5_debug_server"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCq60lia0S2EnAJfAj3r5y7+QGkXgDLLy4/ECv7d0Akd7t4JaJ49h9o2W3yByKlWJaLsHmocu4xbzk5h+L191los/DSQyUax+n2I1oHlYxyjUVS4OD+Zfi3JHBygcNApIuSvZY0yQR/1mmYHe5m3VCVFnQlVYHr/k45GxXLJR8NNpIABNmIMIhpEpVdlOtpF0nc0GDqBsBOMycwf2ffF7CSBszg7nlOQbgelFhIiielT7IAmFIGVI9JTjNfB49t8AjHefLrkwV16jZ10jkAK2qUQ0gFXJB8lDnow6SQYD+WHlkL26Qgj80e73wADyys4BWkVJYsc/lbX5iOZ/tqYaQGyZFcNIqByiF6At8Q8HjKbKxEt9bl85mYd90E7+c2E+qY5HmKmYqU4/ocIxXyIM6CuhI0oO6Z7kHe0EiZP32EMUWzIPwLB5nsMS+PFNlS3OD6L5fDCVAPfLbWhgH48nFu7nRoY9zzwaoHvqE3MYHy9N/6HC7xN5hJkOyA/lDf2eE= ichigo@Macbook.local"
}

data "aws_ssm_parameter" "amzn2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "igsr5_debug_server" {
  ami                    = data.aws_ssm_parameter.amzn2_ami.value
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.igsr5_debug_server_key_pair.id
  subnet_id              = aws_subnet.igsr5_public_0.id
  vpc_security_group_ids = [module.http_pub_sg.security_group_id, module.ssh_pub_sg.security_group_id]
  tags = {
    Name = "igsr5-debug"
  }
  lifecycle {
    ignore_changes = [ami]
  }
}

// resource "aws_key_pair" "igsr5_gmo_practice_server" {
//   key_name   = "igsr5_gmo_practice_server"
//   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCq60lia0S2EnAJfAj3r5y7+QGkXgDLLy4/ECv7d0Akd7t4JaJ49h9o2W3yByKlWJaLsHmocu4xbzk5h+L191los/DSQyUax+n2I1oHlYxyjUVS4OD+Zfi3JHBygcNApIuSvZY0yQR/1mmYHe5m3VCVFnQlVYHr/k45GxXLJR8NNpIABNmIMIhpEpVdlOtpF0nc0GDqBsBOMycwf2ffF7CSBszg7nlOQbgelFhIiielT7IAmFIGVI9JTjNfB49t8AjHefLrkwV16jZ10jkAK2qUQ0gFXJB8lDnow6SQYD+WHlkL26Qgj80e73wADyys4BWkVJYsc/lbX5iOZ/tqYaQGyZFcNIqByiF6At8Q8HjKbKxEt9bl85mYd90E7+c2E+qY5HmKmYqU4/ocIxXyIM6CuhI0oO6Z7kHe0EiZP32EMUWzIPwLB5nsMS+PFNlS3OD6L5fDCVAPfLbWhgH48nFu7nRoY9zzwaoHvqE3MYHy9N/6HC7xN5hJkOyA/lDf2eE= ichigo@Macbook.local"
// }
// 
// resource "aws_instance" "igsr5_gmo_practice_server" {
//   // NOTE: isucon9 予選環境
//   ami                    = "ami-03b1b78bb1da5122f"
//   instance_type          = "t2.micro"
//   key_name               = aws_key_pair.igsr5_gmo_practice_server.id
//   subnet_id              = aws_subnet.igsr5_public_0.id
//   vpc_security_group_ids = [module.http_pub_sg.security_group_id, module.ssh_pub_sg.security_group_id]
//   tags = {
//     Name = "igsr5-gmo-practice-server"
//   }
//   lifecycle {
//     ignore_changes = [ami]
//   }
// }
// 
// resource "aws_key_pair" "igsr5_isucon10_qualify" {
//   key_name   = "igsr5_isucon10_qualify"
//   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCq60lia0S2EnAJfAj3r5y7+QGkXgDLLy4/ECv7d0Akd7t4JaJ49h9o2W3yByKlWJaLsHmocu4xbzk5h+L191los/DSQyUax+n2I1oHlYxyjUVS4OD+Zfi3JHBygcNApIuSvZY0yQR/1mmYHe5m3VCVFnQlVYHr/k45GxXLJR8NNpIABNmIMIhpEpVdlOtpF0nc0GDqBsBOMycwf2ffF7CSBszg7nlOQbgelFhIiielT7IAmFIGVI9JTjNfB49t8AjHefLrkwV16jZ10jkAK2qUQ0gFXJB8lDnow6SQYD+WHlkL26Qgj80e73wADyys4BWkVJYsc/lbX5iOZ/tqYaQGyZFcNIqByiF6At8Q8HjKbKxEt9bl85mYd90E7+c2E+qY5HmKmYqU4/ocIxXyIM6CuhI0oO6Z7kHe0EiZP32EMUWzIPwLB5nsMS+PFNlS3OD6L5fDCVAPfLbWhgH48nFu7nRoY9zzwaoHvqE3MYHy9N/6HC7xN5hJkOyA/lDf2eE= ichigo@Macbook.local"
// }
// 
// 
// resource "aws_instance" "igsr5_isucon10_qualify" {
//   // NOTE: isucon10 予選環境
//   ami                    = "ami-03bbe60df80bdccc0"
//   instance_type          = "t2.micro"
//   key_name               = aws_key_pair.igsr5_isucon10_qualify.id
//   subnet_id              = aws_subnet.igsr5_public_0.id
//   vpc_security_group_ids = [module.http_pub_sg.security_group_id, module.ssh_pub_sg.security_group_id]
//   tags = {
//     Name = "igsr5_isucon10_qualify"
//   }
//   // lifecycle {
//   //   ignore_changes = [ami]
//   // }
// }
