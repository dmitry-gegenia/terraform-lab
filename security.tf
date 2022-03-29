resource "aws_security_group" "public-sg" {
  name        = "lab-vpc-public-sg"
  description = "Lab public security group to allow inbound/outbound"
  vpc_id      = aws_vpc.lab.id

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    self        = false
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    self        = false
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = false
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Lab-public-sg"
  }
}

resource "aws_security_group" "private-sg" {
  name        = "lab-vpc-private-sg"
  description = "Lab private security group to allow inbound/outbound"
  vpc_id      = aws_vpc.lab.id

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    self        = false
    cidr_blocks = [var.subnet-public-1, var.subnet-public-2, var.subnet-private-1, var.subnet-private-1]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    self        = false
    cidr_blocks = [var.subnet-public-1, var.subnet-public-2, var.subnet-private-1, var.subnet-private-1]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = false
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Lab-private-sg"
  }
}

resource "aws_security_group" "mysql-db-sg" {
  name        = "lab-db-sg"
  description = "Mysql DB security group"
  vpc_id      = aws_vpc.lab.id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    self        = false
    cidr_blocks = [var.subnet-private-1, var.subnet-private-2]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = false
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Mysql-SG"
  }
}