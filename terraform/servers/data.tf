data "aws_ami" "ubuntu" {
  most_recent = true
  #filter using name , root device type and virtualization type 
  owners = ["${var.owner}"]     //owner of our image  

  filter {
    name   = "name"
    values = ["${var.image_name}"] 
  }

  filter {
    name   = "root-device-type"
    values = ["${var.image_root_device}"] 
  }
  filter {
    name   = "virtualization-type"
    values = ["${var.image_virt}"] 
  }

}
