provider "aws" {
  region  = var.region
  profile = var.profile
}

# data "aws_availability_zones" "lab-az" {
#   state = "available"
# }