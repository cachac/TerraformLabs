# Internet gateway para salida desde la subnet pública.
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

# NAT gateway para salida desde la subnet pública para las instancias privadas.
resource "aws_eip" "nat_elastic_ip" {
  vpc = true
}

resource "aws_nat_gateway" "ngw" {
  depends_on = [aws_internet_gateway.igw]

  allocation_id = aws_eip.nat_elastic_ip.id
  subnet_id     = aws_subnet.public_subnet.id
}
