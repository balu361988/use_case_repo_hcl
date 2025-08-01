resource "aws_instance" "web" {
  count         = length(var.public_subnet_ids)
  ami           = "ami-0321cd3e0040c7000"
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_ids[count.index]
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.web_sg_id]

  user_data = file("${path.module}/userdata.sh")

  root_block_device {
    volume_size           = 20
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = "${var.env}-web-${count.index}"
  }
}
