data "aws_vpcs" "existing_vpc" {
  tags = {
    Name = "Default_vpc"
  }
}