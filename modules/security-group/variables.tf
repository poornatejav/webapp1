variable "vpc_id" {}
variable "ingressrules" {
  type = list(number)
  default = [ 22,80 ] 
}

variable "egressrules" {
  type = list(number)
  default = [ 0 ]
}