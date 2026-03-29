data "aws_ami" "openvpn" {
  most_recent      = true
  owners           = ["264885124405"]

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image-8fbe3379-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Fetching the public subnet ID from SSM Parameter Store to use it in the aws_instance resource for the bastion host. we should not use default public subnet id because it may change in different environments. so we are fetching it from SSM Parameter Store where we have stored the public subnet id for each environment.    

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project}/${var.environment}/public_subnet_ids"
}

data "aws_ssm_parameter" "openvpn_sg_id" {
  name = "/${var.project}/${var.environment}/openvpn_sg_id"
}