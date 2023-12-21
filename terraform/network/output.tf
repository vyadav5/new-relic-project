output "vpc_info" {
  value = aws_vpc.new-relic.id
}

output "private_subnet_ids" {
  value = aws_subnet.privateSubnet[*].id
}

output "public_subnet_ids" {
  value = aws_subnet.publicSubnet[*].id
}
