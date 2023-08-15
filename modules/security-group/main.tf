resource "aws_security_group" "sg" {
 name = "Ports"
 vpc_id = var.vpc_id 
 dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

 }
 dynamic "egress" {
    iterator = port
    for_each = var.egressrules 
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
 }
}