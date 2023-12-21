# VPC
resource "aws_vpc" "new-relic" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.tenancy

  tags = {
    Name = var.vpc_tag
  }
}

# SUBNETS
resource "aws_subnet" "publicSubnet" {
  count = length(var.pub_subnet_cidr)  // type would be list(string)
  cidr_block = var.pub_subnet_cidr[count.index]
  vpc_id     = aws_vpc.new-relic.id
  availability_zone = "${var.region}${element(["a", "c"], count.index)}"      #retrieve eu-north-1a as AZ <--- for 1st cidr subnet

  tags = {
    Name = "${var.public_subnet_tag}${count.index + 1}"
  }
}

resource "aws_subnet" "privateSubnet" {
  count = length(var.private_subnet_cidr)
  cidr_block = var.private_subnet_cidr[count.index]
  vpc_id     = aws_vpc.new-relic.id
  availability_zone = "${var.region}${element(["a", "c"], count.index)}"  

  tags = {
    Name = "${var.private_subnet_tag}${count.index + 1}"
  }
}

# INTERNET GATEWAY 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.new-relic.id
  tags = {
    Name = var.igw_tag
  }
}

# NAT Gateway
resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.publicSubnet[0].id
  tags ={
    Name = var.nat_name
  }

  depends_on    = [aws_internet_gateway.igw, aws_eip.nat_eip]
}

# ROUTE TABLES
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.new-relic.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    cidr_block = var.cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block = var.default_vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  }

  tags = {
    Name = var.route_tag_pub
  }
  depends_on = [ aws_vpc_peering_connection.vpc_peering ]
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.new-relic.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  route {
    cidr_block = var.cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block = var.default_vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  }

  tags = {
    Name = var.route_tag_priv
  }
  depends_on = [ aws_vpc_peering_connection.vpc_peering ]
}

#ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "public_association" {
  count          = length(aws_subnet.publicSubnet)
  subnet_id      = aws_subnet.publicSubnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_association" {
  count          = length(aws_subnet.privateSubnet)
  subnet_id      = aws_subnet.privateSubnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_vpc_peering_connection" "vpc_peering" {
  vpc_id = data.aws_vpcs.existing_vpc.ids[0]  # Reference the ID of the existing VPC
  peer_vpc_id = aws_vpc.new-relic.id  # Reference the ID of the second VPC
  auto_accept = true
  
  tags = {
    Name = var.peering_tag
  }
}

resource "aws_route" "Existing_route" {
  route_table_id            = "rtb-07a015acf2c6c38fd"
  destination_cidr_block    = var.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  depends_on = [ aws_vpc_peering_connection.vpc_peering ]
}