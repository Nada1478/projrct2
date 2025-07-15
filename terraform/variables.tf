variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "region" {
  default = "eu-north-1"
}

variable "rt_cidr" {
  default = "0.0.0.0/0"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "ami" {
  default = "ami-042b4708b1d05f512"
}

variable "availability_zone" {
  default = "eu-north-1a"
}

variable "sec_cider" {
  default = "0.0.0.0/0"
}