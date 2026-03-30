# Fetch latest Amazon Linux 2 AMI (Free Tier compatible)
data "aws_ami" "openvpn" {
  most_recent = true
  owners      = ["137112412989"] # Amazon Linux owner

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Fetch public subnet IDs from SSM
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project}/${var.environment}/public_subnet_ids"
}

# Fetch OpenVPN security group ID from SSM
data "aws_ssm_parameter" "openvpn_sg_id" {
  name = "/${var.project}/${var.environment}/openvpn_sg_id"
}