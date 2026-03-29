variable "project" {
    default = "roboshop"
  
}

variable "environment" {

    default = "dev"
  
}

# The "sg_names" variable is a list of security group names that are used in the infrastructure. It includes names for database security groups (mongodb, redis, rabbitmq, mysql), backend security groups (catalogue, user, cart, shipping, payment), backend application load balancer (ALB) security group (backend_alb), frontend security group (frontend), frontend ALB security group (frontend_alb), and bastion host security group (bastion). This variable can be used to create and manage security groups in the AWS environment.
variable "sg_names" {

    type = list

    default = [
        
        #database 
        "mongodb", "redis", "rabbitmq", "mysql",

        #backend
        "catalogue", "user", "cart", "shipping", "payment",

        #backend_alb

            "backend_alb",

            "frontend",

        #frontend_alb
            "frontend_alb",

        #bastion
            "bastion",
        
        #openvpn
            "openvpn"
                
        
        
        ]
  
}
