resource "aws_instance" "openvpn" {
  ami           = local.ami_id
  instance_type = "t3.small"
  subnet_id = local.public_subnet_id
  vpc_security_group_ids = [local.openvpn_sg_id]
   
  user_data = file("vpn.sh") # we are using user_data to run the bootstrap script to update the /etc/hosts file in all the instances with the private IP address of the database instance. this is required because we are using private IP address to connect to the database instance from other instances. so whenever we launch a new instance then we need to update the /etc/hosts file in all the instances with the private IP address of the database instance. this is required because we are using private IP address to connect to the database instance from other instances. so whenever we launch a new instance then we need to update the /etc/hosts file in all the instances with the private IP address of the database instance.

  
  tags = merge (
    

    {
      Name = "${var.project}-${var.environment}-openvpn"
    },local.common_tags
  )
}