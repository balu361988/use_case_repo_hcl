resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = { Name = "uc10-vpc" }
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet1_cidr
  availability_zone       = var.az1
  map_public_ip_on_launch = true
  tags = { Name = "uc10-subnet-1" }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet2_cidr
  availability_zone       = var.az2
  map_public_ip_on_launch = true
  tags = { Name = "uc10-subnet-2" }
}

output "subnet_ids" {
  value = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

output "vpc_id" {
  value = aws_vpc.main.id
}
