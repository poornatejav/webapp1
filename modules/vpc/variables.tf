variable "region" {}
variable "project" {}
variable "vpc_cidr" {}
variable "public_cidr" {type = list(string)}
variable "private_cidr" {type = list(string)}
