resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [var.all_ipv4_cidr]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [var.all_ipv4_cidr]
  }

  tags = {
    Name = "ec2_security_group"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "alb"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [var.all_ipv4_cidr]
  }

  # Allow all outbound traffic.
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [var.all_ipv4_cidr]
  }

  tags = {
    Name = "alb_security_group"
  }
}