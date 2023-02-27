output "gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "nat_id" {
  value = aws_nat_gateway.Nat.id
}

output "public_subnet1_id" {
  value = aws_subnet.subnets_public["subnet1"].id
}

output "public_subnet2_id" {
  value = aws_subnet.subnets_public["subnet3"].id
}

output "private_subnet1_id" {
  value = aws_subnet.subnets_private["subnet2"].id
}

output "private_subnet2_id" {
  value = aws_subnet.subnets_private["subnet4"].id
} 

output "public_route_table_id" {
  value = aws_route_table.route_table["table1"].id
}


output "private_route_table_id" {
  value = aws_route_table.route_table["table2"].id
}
output "vpc-id" {
 value = aws_vpc.my_eks_environment.id

}