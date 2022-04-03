provider "aws" {
  region  = var.region
  profile = var.profile
}

module "asg_app" {
  source = "./modules/asg"

  instance-image           = var.instance-image
  instance-type            = var.instance-type
  as-min-size              = var.as-min-size
  as-max-size              = var.as-max-size
  as-desired-capacity      = var.as-desired-capacity
  db-name                  = var.db_name
  db-user                  = var.db_user
  db-pass                  = var.db_pass
  db-host                  = aws_db_instance.lab-db.address
  public-security-groups   = [aws_security_group.public-sg.id]
  private-security-groups  = [aws_security_group.private-sg.id]
  php-dns-name             = aws_lb.lab-php-lb.dns_name
  priv-vpc-zone-identifier = [aws_subnet.lab-private-subnet-1.id, aws_subnet.lab-private-subnet-2.id]
  pub-vpc-zone-identifier  = [aws_subnet.lab-public-subnet-1.id, aws_subnet.lab-public-subnet-2.id]
}