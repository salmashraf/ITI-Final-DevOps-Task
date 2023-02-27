module "networking" {
 source  = "./networking"
 vpc_name = "DevOps-VPC"
 vpc_cidr = "10.0.0.0/16"
 pub_route = "0.0.0.0/0"
 # pub_cidr = ["0.0.0.0/0"]
 internet-gateway = "cluster-igw" 

  public_subnets = {
       "subnet1" = { cidr = "10.0.0.0/24" , az = "us-east-1a" },
       "subnet3" = { cidr = "10.0.2.0/24" , az = "us-east-1b" }
    }
  private_subnets = {
       "subnet2" = { cidr = "10.0.1.0/24" , az = "us-east-1a" },
       "subnet4" = { cidr = "10.0.3.0/24" , az = "us-east-1b" }

    } 


 route_table = {
     "table1" = "pub_route_table"
     "table2" = "priv_route_table"
     }
    /* priv_route_names = {
    "table2" = "priv_route_table1"
     # "table4" = "priv_route_table2"
    } */ 

    route = {
    "public_route" = { id = module.networking.public_route_table_id, destination = module.networking.gateway_id },
    "private_route" = { id = module.networking.private_route_table_id, destination = module.networking.nat_id }
    }
    
   public_association = {
    "publicSubnet_association1"  = { id = module.networking.public_subnet1_id, tableid = module.networking.public_route_table_id },
    "publicSubnet_association2"  = { id = module.networking.public_subnet2_id, tableid = module.networking.public_route_table_id },
   }
   private_association = {
    "privateSubnet_association1" = { id = module.networking.private_subnet1_id, tableid = module.networking.private_route_table_id },
    "privateSubnet_association2" = { id = module.networking.private_subnet2_id, tableid = module.networking.private_route_table_id }
   } 
}


 module "eks" {
  source  = "./eks"
  vpc_name = "DevOps-VPC"
  vpc_cidr = "10.0.0.0/16"
  pub_cidr = ["0.0.0.0/0"]
  master-role  = "eks_role"
  worker_role = "worker-nodes-role"
  master = "master-node"
 /* pub_subnet_ids = {
  
   "subnet_id_1" = { id = module.networking.public_subnet1_id }
   "subnet_id_2" = { id = module.networking.public_subnet2_id }
 } */

 nodes_name = "DevOps-workernodes"
 
  priv_subnet_ids = [
    module.networking.private_subnet1_id ,
    module.networking.private_subnet2_id  
  ]
  
    
 
#  public_subnets = {
#        "subnet1" = { cidr = "10.0.0.0/24" , az = "us-east-1a" },
#        "subnet3" = { cidr = "10.0.2.0/24" , az = "us-east-1b" }
#     }
#   private_subnets = {
#        "subnet2" = { cidr = "10.0.1.0/24" , az = "us-east-1a" },
#        "subnet4" = { cidr = "10.0.3.0/24" , az = "us-east-1b" }

#     } 

 }  

module "jump-host" {
  source  = "./jump-host"
  pub_cidr = ["0.0.0.0/0"]
  ec2_subnet = module.networking.public_subnet1_id 
  security_group = "ec2 security group"
  vpcID          = module.networking.vpc-id
  instance_ami    = "ami-0dfcb1ef8550277af"
  instance_type = "t2.micro"
  ec2_name = "public_ec2"
} 
 
  
