data "aws_rds_engine_version" "mariadb" {
  engine = "mariadb"
  #  preferred_versions = ["10.6.7"]
}

resource "aws_db_subnet_group" "lab-db-sg" {
  name       = "lab-db-sg"
  subnet_ids = [aws_subnet.lab-private-subnet-1.id, aws_subnet.lab-private-subnet-2.id]

  tags = {
    Name = "Lab DB subnet group"
  }
}

resource "aws_db_instance" "lab-db" {
  identifier            = "lab-rds"
  instance_class        = "db.t2.micro"
  allocated_storage     = "20"
  max_allocated_storage = "100"
  engine                = "mariadb"
  engine_version        = "10.6.7"

  username = "admin"
  password = "12345678"

  db_subnet_group_name=aws_db_subnet_group.lab-db-sg.name
  multi_az=false
  vpc_security_group_ids = [aws_security_group.mysql-db-sg.id]
}



# resource "aws_db_security_group" "lab-db-sg" {
#   name = "lab-rds-sg"

#   ingress {
#     cidr = var.subnet-private-1
#   }
#   ingress {
#     cidr = var.subnet-private-2
#   }
# }