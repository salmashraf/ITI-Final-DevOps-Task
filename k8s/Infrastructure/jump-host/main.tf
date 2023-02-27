resource "aws_security_group" "ec2_security" {
  name        = var.security_group
  vpc_id      = var.vpcID

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.pub_cidr
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.pub_cidr
  }

  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.pub_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.pub_cidr
  }

  tags = {
    Name = var.security_group
  }
}

resource "aws_instance" "public-ec2" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id = var.ec2_subnet
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2_security.id]
  key_name = "ansible-key"

  tags = {
    Name = var.ec2_name
  } 
}




