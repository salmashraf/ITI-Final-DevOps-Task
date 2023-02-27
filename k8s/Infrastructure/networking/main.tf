resource "aws_vpc" "my_eks_environment" {
 cidr_block = var.vpc_cidr
 tags = {
    "Name" = var.vpc_name
 }
}

resource "aws_subnet" "subnets_public" {
  vpc_id     = aws_vpc.my_eks_environment.id
  for_each = var.public_subnets
  cidr_block = each.value.cidr
  availability_zone = each.value.az
  tags = {
   Name = each.key
  }
} 

resource "aws_subnet" "subnets_private" {
  for_each = var.private_subnets
  cidr_block = each.value.cidr
  vpc_id     = aws_vpc.my_eks_environment.id
  availability_zone = each.value.az
  tags = {
   Name = each.key
  }
}  
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_eks_environment.id

  tags = {
    Name = var.internet-gateway
  }
}

resource "aws_eip" "elastic_ip" {
  vpc = true
}

resource "aws_nat_gateway" "Nat" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id = aws_subnet.subnets_public["subnet1"].id
  tags = {
    "Name" = "NatGateway"
  }
    depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.my_eks_environment.id
  for_each = var.route_table
  
  tags = {
    Name = each.value   
  }
} 


resource "aws_route" "pub_route" {
  for_each               = var.route
  route_table_id         = each.value.id
  destination_cidr_block = var.pub_route
  gateway_id             = each.value.destination
}

/* resource "aws_route" "priv_route" {
  for_each               = var.route
  route_table_id         = each.value.id
  destination_cidr_block = var.pub_route
  gateway_id             = each.value.destination
}  */ 


 resource "aws_route_table_association" "private_association" {
    for_each       = var.private_association
    subnet_id      = each.value.id
    route_table_id = each.value.tableid
  }

resource "aws_route_table_association" "public-association" {
  for_each       = var.public_association
  subnet_id      = each.value.id
  route_table_id = each.value.tableid
} 

/* resource "aws_route_table_association" "subnet_association" {
  for_each       = var.subnet_association
  subnet_id      = each.value.subnetID
  route_table_id = each.value.routingTableID
} */


