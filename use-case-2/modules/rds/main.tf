resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "custom-db-subnet-group-terra"
  subnet_ids = var.private_subnets

  tags = {
    Name = "db-subnet-group-terra"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg-terra"
  description = "Allow MySQL from web SG"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.web_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "webappdb"
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  multi_az             = true
  skip_final_snapshot  = true
  publicly_accessible  = false
  identifier           = "custom-db-terra"
  tags = {
    Name = "custom-db"
  }
}

