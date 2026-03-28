// resource "aws_vpc_endpoint" "s3" {
//   vpc_id            = aws_vpc.igsr5.id
//   service_name      = "com.amazonaws.ap-northeast-1.s3"
//   vpc_endpoint_type = "Gateway"
// }
// 
// resource "aws_vpc_endpoint" "ecr_dkr" {
//   vpc_id              = aws_vpc.igsr5.id
//   service_name        = "com.amazonaws.ap-northeast-1.ecr.dkr"
//   vpc_endpoint_type   = "Interface"
//   subnet_ids          = [aws_subnet.igsr5_private_0.id, aws_subnet.igsr5_private_1.id]
//   security_group_ids  = [module.vpc_endpoint_sg.security_group_id]
//   private_dns_enabled = true
// }
// 
// resource "aws_vpc_endpoint" "ecr_api" {
//   vpc_id              = aws_vpc.igsr5.id
//   service_name        = "com.amazonaws.ap-northeast-1.ecr.api"
//   vpc_endpoint_type   = "Interface"
//   subnet_ids          = [aws_subnet.igsr5_private_0.id, aws_subnet.igsr5_private_1.id]
//   security_group_ids  = [module.vpc_endpoint_sg.security_group_id]
//   private_dns_enabled = true
// }
