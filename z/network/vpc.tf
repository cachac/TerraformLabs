resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "VPC ${var.lab_name}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id      = aws_vpc.vpc.id
  cidr_block  = var.public_cidr_block
	availability_zone = var.public_zone
}

resource "aws_subnet" "private_subnet" {
  vpc_id      = aws_vpc.vpc.id
  cidr_block  = var.private_cidr_block
	availability_zone = var.private_zone
}
