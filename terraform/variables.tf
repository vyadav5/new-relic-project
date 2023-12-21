#VPC VARIABLES
variable cidr_block {
    type = string
    description = "The CIDR block for the VPC"
}

variable tenancy {
    type = string
    description = "The tenancy of the VPC instances"
}

variable vpc_tag {
    type = string
    description = "The tag for the VPC"
}

variable default_vpc_cidr {
    type = string
    description = "Cidr for default vpc"
}

variable peering_tag {
    type = string
    description = "Cidr for default vpc"
}

#SUBNET VARIABLES
variable pub_subnet_cidr {
    type = list(string)
    description = "The CIDR blocks for public subnets"
}

variable public_subnet_tag {
    type = string
    description = "The tag for public subnets"
}

variable private_subnet_tag {
    type = string
    description = "The tag for private subnets"
}

variable private_subnet_cidr {
    type = list(string)
    description = "The CIDR blocks for private subnets"
}

variable "region" {
  description = "The AWS region where resources will be created"
  default     = "eu-north-1"  # default region
}

# CONNECTIVITY
variable igw_tag {
    type = string
    description = "The tag for the Internet Gateway"
}

variable route_tag_pub {
    type = string
    description = "The tag for the public route table"
}

variable route_tag_priv {
    type = string
    description = "The tag for the private route table"
}

variable nat_name {
    type = string
    description = "The name for the NAT Gateway"
}

# INSTANCE VARIABLES
variable instance_type {
    type = string
    description = "The type of EC2 instances"
}

variable image_name {
    type = string
    description = "The name of the AMI image"
}

variable image_root_device {
    type = string
    description = "The root device of the AMI image"
}

variable image_virt {
    type = string
    description = "The virtualization type of the AMI image"
}

variable owner {
    type = string
    description = "The owner of the AMI image"
}

variable "instance_names" {
  type    = list(string)
  default = ["bastion_instance1", "public_instance2", "private_instance1", "private_instance2"]
}


variable private_instance_tag {
    type = string
    description = "The tag for private instances"
}

variable tool {
    type = string
    description = "The operating system tag for the instances"
}

variable key_name {
    type = string
    description = "key pair name"
}

variable key_path {
    type = string
    description = "key pair path"
}

# variable key_path {
#     type = string
#     description = "key pair path"
# }

#SECURITY GROUP VARIABLES
variable public_secure_grp {
    type = string
    description = "The name for the security group of public instances"
}

variable private_secure_grp {
    type = string
    description = "The name for the security group of private instances"
}
