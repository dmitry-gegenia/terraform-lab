resource "aws_route_table" "public-route-a" {
  vpc_id = aws_vpc.lab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags = {
    Name = "Lab public subnet-1 ${var.az-a}"
  }
}

resource "aws_route_table" "public-route-b" {
  vpc_id = aws_vpc.lab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags = {
    Name = "Lab public subnet-2 ${var.az-b}"
  }
}

resource "aws_route_table_association" "prs1" {
  subnet_id      = aws_subnet.lab-public-subnet-1.id
  route_table_id = aws_route_table.public-route-a.id
}

resource "aws_route_table_association" "prs2" {
  subnet_id      = aws_subnet.lab-public-subnet-2.id
  route_table_id = aws_route_table.public-route-b.id
}

#PRIVATE
resource "aws_route_table" "private-route-a" {
  vpc_id = aws_vpc.lab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-subnet-1.id
  }

  tags = {
    Name = "Lab private subnet-1 ${var.az-a}"
  }
}

resource "aws_route_table" "private-route-b" {
  vpc_id = aws_vpc.lab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-subnet-2.id
  }

  tags = {
    Name = "Lab private subnet-2 ${var.az-b}"
  }
}

resource "aws_route_table_association" "prs3" {
  subnet_id      = aws_subnet.lab-private-subnet-1.id
  route_table_id = aws_route_table.private-route-a.id
}

resource "aws_route_table_association" "prs4" {
  subnet_id      = aws_subnet.lab-private-subnet-2.id
  route_table_id = aws_route_table.private-route-b.id
}
