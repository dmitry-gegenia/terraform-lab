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