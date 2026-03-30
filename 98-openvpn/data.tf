# Step 1: Fetch the latest Free Tier Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Step 2: Read subnet and security group from SSM (your existing setup)
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project}/${var.environment}/public_subnet_ids"
}

data "aws_ssm_parameter" "openvpn_sg_id" {
  name = "/${var.project}/${var.environment}/openvpn_sg_id"
}

# Step 3: Launch EC2 instance and install OpenVPN via user_data
resource "aws_instance" "openvpn" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro" # Free Tier eligible
  subnet_id              = element(split(",", data.aws_ssm_parameter.public_subnet_ids.value), 0)
  vpc_security_group_ids = [data.aws_ssm_parameter.openvpn_sg_id.value]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y openvpn
              # Optional: enable OpenVPN service on boot
              systemctl enable openvpn
              systemctl start openvpn
              EOF

  tags = {
    Name = "roboshop-dev-openvpn"
  }
}