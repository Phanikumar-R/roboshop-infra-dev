resource "aws_security_group_rule" "bastion_internet" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  /* cidr_blocks       = ["0.0.0.0/0"] */ # while creating security group rules, we should avoid using CIDR block
  cidr_blocks       = [local.my_ip]
  # which segment of the network can access this rule, here we are allowing only my ip to access bastion on port 22
  security_group_id = local.bastion_sg_id
}

resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # which segment of the network can access this rule, here we are allowing only bastion to access mongodb on port 22
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.mongodb_sg_id
}

resource "aws_security_group_rule" "mongodb_catalogue" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  # which segment of the network can access this rule, here we are allowing only bastion to access mongodb on port 22
  source_security_group_id = local.catalogue_sg_id
  security_group_id = local.mongodb_sg_id
}

resource "aws_security_group_rule" "mongodb_user" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  # which segment of the network can access this rule, here we are allowing only bastion to access mongodb on port 22
  source_security_group_id = local.user_sg_id
  security_group_id = local.mongodb_sg_id
}

resource "aws_security_group_rule" "redis_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # which segment of the network can access this rule, here we are allowing only bastion to access mongodb on port 22
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.redis_sg_id
}

