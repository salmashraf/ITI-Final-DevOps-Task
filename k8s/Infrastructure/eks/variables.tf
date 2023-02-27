variable "subnet_id_1" {
  type = string
  default = "subnet-your_first_subnet_id"
 }
 
variable "subnet_id_2" {
  type = string
  default = "subnet-your_second_subnet_id"
 }

variable "master" {
  type = string
 }

/* variable "pub_subnet_ids" {
  type = map 
 } */ 

variable "worker_role" {
  type = string
 }
 
variable "master-role" {
  type = string
 }

variable "nodes_name" {
  type = string
 }

/* variable "priv_subnet_ids" {
  type = map 
 } */ 
 
/* variable "subnet_id_1" {
  type = string
}
 
 variable "subnet_id_2" {
  type = string
} */ 
 
variable "vpc_name" {
type = string
}

variable "vpc_cidr" {
type = string 
}

# variable "public_subnets" {
#       type = map  # list(any) 
# }  

# variable "private_subnets" {
#       type = map  # list(any) 
# }

variable "pub_cidr" {
  type        = list(string )
}

variable "priv_subnet_ids" {
  
}

