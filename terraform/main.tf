#NETWORK MODULE
module "network" {
  source = "./network"

  #VPC vars
  cidr_block = var.cidr_block
  tenancy = var.tenancy
  vpc_tag = var.vpc_tag
  default_vpc_cidr = var.default_vpc_cidr
  peering_tag = var.peering_tag

  # Subnet vars
  pub_subnet_cidr = var.pub_subnet_cidr
  public_subnet_tag = var.public_subnet_tag
  private_subnet_tag = var.private_subnet_tag
  private_subnet_cidr = var.private_subnet_cidr
  region = var.region

  # gateway vars
  igw_tag = var.igw_tag
  nat_name = var.nat_name

  # route-table vars 
  route_tag_pub = var.route_tag_pub
  route_tag_priv = var.route_tag_priv

}

# SERVERS MODULE
module "servers" {
  source = "./servers"

  # Instance vars
  instance_type            = var.instance_type
  image_name               = var.image_name
  image_root_device        = var.image_root_device
  image_virt               = var.image_virt
  owner                    = var.owner
  tool                     = var.tool
  private_instance_tag     = var.private_instance_tag
  key_name                 = var.key_name
  instance_names           = var.instance_names
  key_path                 = var.key_path

  # Security groups
  private_secure_grp       = var.private_secure_grp
  public_secure_grp        = var.public_secure_grp

  #vpc reference
  vpc_id = module.network.vpc_info

  #subnets reference
  public_subnet_ids = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids

}

