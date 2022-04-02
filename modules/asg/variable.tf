variable "region" {
  type    = string
  default = "us-east-1"
}

variable "profile" {
  type    = string
  default = "lab"
}

variable "az-a" {
  type    = string
  default = "us-east-1a"
}

variable "az-b" {
  type    = string
  default = "us-east-1b"
}

variable "vpc-cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet-public-1" {
  type    = string
  default = "10.0.1.0/24"
}

variable "subnet-public-2" {
  type    = string
  default = "10.0.2.0/24"
}

variable "subnet-private-1" {
  type    = string
  default = "10.0.3.0/24"
}

variable "subnet-private-2" {
  type    = string
  default = "10.0.4.0/24"
}

variable "instance-type" {
  type    = string
  default = "t2.micro"
}

variable "instance-image" {
  type    = string
  default = "ami-0e472ba40eb589f49"
}

variable "as-min-size" {
  type = number
  default = 1
}

variable "as-max-size" {
  type = number
  default = 5
}

variable "as-desired-capacity" {
  type = number
  default = 1
}

variable "db_name" {
  type    = string
}
variable "db_user" {
  type    = string
}

variable "db_pass" {
  type    = string
}