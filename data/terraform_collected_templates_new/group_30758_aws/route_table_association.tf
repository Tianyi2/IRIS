resource "aws_route_table_association" "igsr5_public_0" {
  subnet_id      = aws_subnet.igsr5_public_0.id
  route_table_id = aws_route_table.igsr5_public.id
}

resource "aws_route_table_association" "igsr5_public_1" {
  subnet_id      = aws_subnet.igsr5_public_1.id
  route_table_id = aws_route_table.igsr5_public.id
}

resource "aws_route_table_association" "igsr5_private_0" {
  subnet_id      = aws_subnet.igsr5_private_0.id
  route_table_id = aws_route_table.igsr5_private.id
}

resource "aws_route_table_association" "igsr5_private_1" {
  subnet_id      = aws_subnet.igsr5_private_1.id
  route_table_id = aws_route_table.igsr5_private.id
}
