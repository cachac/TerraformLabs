
resource "aws_route_table" "rt_igw" {
  depends_on = [aws_internet_gateway.igw, aws_vpc.vpc]
  vpc_id     = aws_vpc.vpc.id
}

# route from 0.0.0.0/0 to igw
resource "aws_route" "publicRoute" {
  depends_on             = [aws_route_table.rt_igw]
  route_table_id         = aws_route_table.rt_igw.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# associations
resource "aws_route_table_association" "public_subnet_association_a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt_igw.id
}

