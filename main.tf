provider "aws" {
  region  = var.region
  profile = var.profile
}

module "asg_app" {
  source = "./modules/asg"

  instance-image  = var.instance-image
  instance-type = var.instance-type
  as-min-size = var.as-min-size
  as-max-size = var.as-max-size
  as-desired-capacity = var.as-desired-capacity
  db_name = var.db_name
  db_user = var.db_user
  db_pass = var.db_pass
}