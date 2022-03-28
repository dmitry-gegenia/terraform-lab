#SUBNETS
resource "aws_subnet" "lab-public-subnet-1" {
  vpc_id                  = aws_vpc.lab.id
  cidr_block              = var.subnet-public-1
  availability_zone       = var.az-a
  map_public_ip_on_launch = true

  tags = {
    Name = "lab-public-subnet-1-${var.az-a}"
    Tier = "Public"
  }
}

resource "aws_subnet" "lab-public-subnet-2" {
  vpc_id                  = aws_vpc.lab.id
  cidr_block              = var.subnet-public-2
  availability_zone       = var.az-b
  map_public_ip_on_launch = true

  tags = {
    Name = "lab-public-subnet-2-${var.az-b}"
    Tier = "Public"
  }
}

resource "aws_subnet" "lab-private-subnet-1" {
  vpc_id                  = aws_vpc.lab.id
  cidr_block              = var.subnet-private-1
  availability_zone       = var.az-a
  map_public_ip_on_launch = false

  tags = {
    Name = "lab-private-subnet-1-${var.az-a}"
    Tier = "Private"
  }
}

resource "aws_subnet" "lab-private-subnet-2" {
  vpc_id                  = aws_vpc.lab.id
  cidr_block              = var.subnet-private-2
  availability_zone       = var.az-b
  map_public_ip_on_launch = false

  tags = {
    Name = "lab-private-subnet-2-${var.az-b}"
    Tier = "Private"
  }
}