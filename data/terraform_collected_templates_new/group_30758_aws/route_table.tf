resource "aws_route_table" "igsr5_public" {
  vpc_id = aws_vpc.igsr5.id

  tags = {
    Name = "igsr5_public"
  }
}

resource "aws_route_table" "igsr5_private" {
  vpc_id = aws_vpc.igsr5.id

  tags = {
    Name = "igsr5_private"
  }
}
