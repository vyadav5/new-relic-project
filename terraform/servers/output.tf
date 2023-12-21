# ./servers/outputs.tf

output "instance_ids" {
  value = aws_instance.private_instances[*].id
}
