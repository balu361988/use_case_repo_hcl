resource "aws_instance" "devlake" {
  ami                         = var.ami_id
  instance_type               = "t2.medium"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]  # ✅ FIXED
  associate_public_ip_address = true
  key_name                    = var.key_name

  root_block_device {
    volume_size = 25
    volume_type = "gp2"
  }

  user_data = file("${path.module}/user-data.sh")

  tags = {
    Name = "devlake-ec2"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "${var.project_name}-ec2-sg"
  description = "Allow traffic from ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

