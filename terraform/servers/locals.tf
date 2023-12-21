locals {
  common_instance_tags = {
    tool = var.tool
  }

  private_instance_tags = [
    merge(local.common_instance_tags, {
      Name = "${var.private_instance_tag}1"
    }),
    merge(local.common_instance_tags, {
      Name = "${var.private_instance_tag}2"
    })
  ]
}