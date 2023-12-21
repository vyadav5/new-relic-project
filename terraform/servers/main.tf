# INSTANCES 
resource "aws_instance" "ec2_instance" {
  count                      = length(var.instance_names)
  ami                        = data.aws_ami.ubuntu.id
  instance_type              = var.instance_type
  subnet_id                  = var.public_subnet_ids[count.index]
  associate_public_ip_address = true
  key_name                   = aws_key_pair.key_pair.key_name
  vpc_security_group_ids     = [aws_security_group.public_security_grp.id]
  tags                       = merge(local.common_instance_tags, { Name = var.instance_names[count.index] })

}


resource "aws_instance" "private_instances" {
  count         = length(var.private_subnet_ids)
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_ids[count.index]
  key_name = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.public_security_grp.id]

  tags = local.private_instance_tags[count.index]
}

# SECURITY GROUPS
resource "aws_security_group" "public_security_grp" {
  name        = "public_sg_grp"
  description = "Security group for public EC2 instances"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [22, 80, 443, -1]

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = ingress.value == -1 ? "icmp" : "tcp"  #set protocol to icmp when port==-1 otherwise tcp
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.public_secure_grp
  }
}


# Generate rsa key pair for instances
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Generate aws .pem Key pair
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name  
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

# download key in system
resource "local_file" "private_key" {
  content = tls_private_key.rsa_4096.private_key_pem
  filename = var.key_name
}
