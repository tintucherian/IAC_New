#creation of vpc
resource "aws_vpc" "vpcmain" {
 cidr_block = "10.0.0.0/16" 
 tags = {
   Name = "Project VPC"
 }
}

#creation of public subnet
resource "aws_subnet" "public_subnets" { 
 vpc_id     = aws_vpc.vpcmain.id
 cidr_block = var.public_subnet_cidr
 availability_zone = var.availability_zone
 tags = {
   Name = "Public Subnet"
 }
 depends_on = [
    aws_vpc.vpcmain
  ]
}

#creation of private subnet
# resource "aws_subnet" "private_subnets" { 
#  vpc_id     = aws_vpc.vpcmain.id
#  cidr_block = var.private_subnet_cidr
#  availability_zone = var.availability_zone
#  tags = {
#    Name = "Private Subnet"
#  }
#  depends_on = [
#     aws_vpc.vpcmain
#   ]
# }

#creation of internet gateway
resource "aws_internet_gateway" "gw" {
 vpc_id = aws_vpc.vpcmain.id
 tags = {
   Name = "Project VPC IG"
 }
 depends_on = [
    aws_vpc.vpcmain,
    aws_subnet.public_subnets,    
  ]
}

# ceation of route table
resource "aws_route_table" "routetbl" {
 vpc_id = aws_vpc.vpcmain.id
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.gw.id
 }
 tags = {
   Name = "2nd Route Table"
 }
 depends_on = [
  aws_vpc.vpcmain,
  aws_internet_gateway.gw
 ]
}

#Association of public subnet to route table
resource "aws_route_table_association" "public_subnet_association" {
 subnet_id      = aws_subnet.public_subnets.id
 route_table_id = aws_route_table.routetbl.id
 depends_on = [
    aws_vpc.vpcmain,
    aws_subnet.public_subnets,    
    aws_route_table.routetbl
  ]
}