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

variable "db-name" {
  type    = string
}
variable "db-user" {
  type    = string
}

variable "db-pass" {
  type    = string
}

variable "db-host" {
  type    = string
}

variable "public-security-groups" {
  type = list(string)  
}

variable "private-security-groups" {
  type = list(string)  
}

variable "php-dns-name" {
  type = string  
}

variable "priv-vpc-zone-identifier" {
  type =list(string)
}

variable "pub-vpc-zone-identifier" {
  type =list(string)
}