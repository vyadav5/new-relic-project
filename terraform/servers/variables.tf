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
  description = "public instance tags"
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

#SECURITY GROUP VARIABLES
variable public_secure_grp {
    type = string
    description = "The name for the security group of public instances"
}

variable private_secure_grp {
    type = string
    description = "The name for the security group of private instances"
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type    = list(string)
}

variable "public_subnet_ids" {
  type    = list(string)
}

