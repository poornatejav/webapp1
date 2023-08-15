resource "aws_instance" "ec2" {
  ami                          = data.aws_ami.ubuntu.id
  instance_type                = var.instance_type
  subnet_id                    = var.subnet_id
  security_groups              = [var.security_group_id]
  iam_instance_profile         = var.instance_profile
  key_name                     = var.key_name
  user_data                    = var.user_data
}