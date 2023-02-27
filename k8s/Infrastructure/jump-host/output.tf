output "ec2_sg_id" {
  value = aws_security_group.ec2_security.id
}

 output "public_ec2_id_1" {
  value = aws_instance.public-ec2.id
}

