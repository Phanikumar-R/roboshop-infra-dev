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

resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # which segment of the network can access this rule, here we are allowing only bastion to access mongodb on port 22
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.mysql_sg_id
}
resource "aws_security_group_rule" "rabbitmq_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # which segment of the network can access this rule, here we are allowing only bastion to access mongodb on port 22
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.rabbitmq_sg_id
}


# here we need to give port 80 and aws won't give permission to port 22

resource "aws_security_group_rule" "backend_alb_bastion" {   
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  # which segment of the network can access this rule, here we are allowing only bastion to access mongodb on port 22
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.backend_alb_sg_id
}
resource "aws_security_group_rule" "catalogue_bastion" {   
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # which segment of the network can access this rule, here we are allowing only bastion to access mongodb on port 22
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.catalogue_sg_id
}

resource "aws_security_group_rule" "catalogue_backend_alb" {   
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  # which segment of the network can access this rule, here we are allowing only bastion to access mongodb on port 22
  source_security_group_id = local.backend_alb_sg_id
  security_group_id = local.catalogue_sg_id
}

