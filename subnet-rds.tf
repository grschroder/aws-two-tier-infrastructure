
resource "aws_subnet" "priv-subnet-rds-a" {
  vpc_id                  = var.VPC_ID
  cidr_block              = "10.0.70.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "priv-subnet-rds-a"
  }
}

resource "aws_subnet" "priv-subnet-rds-b" {
  vpc_id                  = var.VPC_ID
  cidr_block              = "10.0.71.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "priv-subnet-rds-b"
  }
}


resource "aws_route_table" "rtable-priv-subnet-rds" {
  vpc_id = var.VPC_ID  

  tags = {
    Name = "rtable-priv-subnet-rds"
  }
}

resource "aws_route_table_association" "rtable-priv-subnet-rds-association-a" {
  subnet_id      = aws_subnet.priv-subnet-rds-a.id
  route_table_id = aws_route_table.rtable-priv-subnet-rds.id  
}

resource "aws_route_table_association" "rtable-priv-subnet-rds-association-b" {
  subnet_id      = aws_subnet.priv-subnet-rds-b.id
  route_table_id = aws_route_table.rtable-priv-subnet-rds.id  
}