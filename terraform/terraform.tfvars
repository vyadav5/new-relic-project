cidr_block = "10.0.0.0/16"  
tenancy = "default"
vpc_tag = "new-relic"
default_vpc_cidr = "172.31.0.0/16"
peering_tag = "VPC-Peering"
instance_names = ["newrelic-bastion_instance1", "newrelic-public_instance2"]


pub_subnet_cidr = ["10.0.0.0/18","10.0.64.0/18"]
public_subnet_tag = "newrelic-public-subnet"
private_subnet_cidr = ["10.0.128.0/18","10.0.192.0/18"]
private_subnet_tag = "newrelic-private-subnet"
region = "eu-north-1"

route_tag_pub = "newrelic-route-pub"
route_tag_priv = "newrelic-route-priv"

igw_tag = "igw-newrelic"
nat_name = "nat-newrelic"

instance_type = "t3.micro"
image_name = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
image_root_device = "ebs"
image_virt = "hvm"
owner = "099720109477"
key_name = "newrelic"
key_path = "/home/ubuntu/newrelic.pem"

public_secure_grp = "newrelic-public_sg"
private_secure_grp = "newrelic-private_sg"
private_instance_tag = "newrelic-private-instance"
tool = "newrelic"
