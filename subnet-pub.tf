resource "aws_subnet" "public-subnet-a" {
  vpc_id     = var.VPC_ID
  cidr_block = "10.0.60.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "public-subnet-a"
  }
}

resource "aws_subnet" "public-subnet-b" {
  vpc_id     = var.VPC_ID
  cidr_block = "10.0.61.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "public-subnet-b"
  }
}