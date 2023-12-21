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

variable default_vpc_cidr {
    type = string
    description = "Cidr for default vpc"
}

variable peering_tag {
    type = string
    description = "Cidr for default vpc"
}
