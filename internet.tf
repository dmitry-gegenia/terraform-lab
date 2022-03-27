resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.lab.id

  tags = {
    Name = "lab-igw"
  }
}

#NAT
resource "aws_eip" "lab-eip-1" {
  vpc        = true
  depends_on = [aws_internet_gateway.internet-gateway]
}

resource "aws_eip" "lab-eip-2" {
  vpc        = true
  depends_on = [aws_internet_gateway.internet-gateway]
}


resource "aws_nat_gateway" "nat-subnet-1" {
  allocation_id     = aws_eip.lab-eip-1.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.lab-private-subnet-1.id
  tags = {
    Name = "Lab private subnet 1 NAT"
  }
  depends_on = [aws_internet_gateway.internet-gateway]
}

resource "aws_nat_gateway" "nat-subnet-2" {
  allocation_id     = aws_eip.lab-eip-2.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.lab-private-subnet-2.id
  tags = {
    Name = "Lab private subnet 2 NAT"
  }
  depends_on = [aws_internet_gateway.internet-gateway]
}