variable "ec2_subnet" {
  type        = string
}

variable "security_group" {
  type        = string 
}

variable "vpcID" {
  type        = string  
}

variable "instance_ami" {
  type        = string  
}

variable "instance_type" {
  type        = string  
}

variable "pub_cidr" {
  type        = list(string )
}

variable "ec2_name" {
  type        = string
}

