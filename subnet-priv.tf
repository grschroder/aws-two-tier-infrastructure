resource "aws_eip" "eip-nat-gw" {    
    
    tags = {
        Name = "eip-nat-gw"
    }
}

resource "aws_nat_gateway" "nat-gw-app-subnet-a" {
  allocation_id = aws_eip.eip-nat-gw.id
  subnet_id     = aws_subnet.public-subnet-a.id

  tags = {
    Name = "nat-gw-app-subnet-a"
  }
}

resource "aws_route_table" "rtable-priv-default" {
  vpc_id = var.VPC_ID

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw-app-subnet-a.id
    }

  tags = {
    Name = "rtable-priv-default"
  }

}

resource "aws_subnet" "priv-subnet-app-a" {
  vpc_id                  = var.VPC_ID
  cidr_block              = "10.0.50.0/24"
  #map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "priv-subnet-app-a"    
  }
}

resource "aws_subnet" "priv-subnet-app-b" {
  vpc_id                  = var.VPC_ID
  cidr_block              = "10.0.51.0/24"
  #map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "priv-subnet-app-b"    
  }
}


resource "aws_route_table_association" "rtable-priv-subnet-app-a" {
  subnet_id      = aws_subnet.priv-subnet-app-a.id
  route_table_id = aws_route_table.rtable-priv-default.id  
}

resource "aws_route_table_association" "rtable-priv-subnet-app-b" {
  subnet_id      = aws_subnet.priv-subnet-app-b.id
  route_table_id = aws_route_table.rtable-priv-default.id  
}