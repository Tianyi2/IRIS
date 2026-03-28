resource "aws_route" "igsr5_public" {
  route_table_id         = aws_route_table.igsr5_public.id
  gateway_id             = aws_internet_gateway.igsr5.id
  destination_cidr_block = "0.0.0.0/0"
}

// resource "aws_route" "igsr5_private" {
//   route_table_id         = aws_route_table.igsr5_private.id
//   nat_gateway_id         = aws_nat_gateway.igsr5.id
//   destination_cidr_block = "0.0.0.0/0"
// }
