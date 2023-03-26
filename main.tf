

#aws connection
provider "aws" {
  region = "ap-south-1" 
}

# EC2 instance creation
resource "aws_instance" "ec2test" {
    ami = var.ami
    instance_type = var.instance_type
    tags = {
        Name = "ec2test"
    }
    key_name = aws_key_pair.testkey.id
    vpc_security_group_ids = [aws_security_group.ssh_access.id] 
    subnet_id = aws_subnet.public_subnets.id
    associate_public_ip_address = true

    depends_on = [
    aws_vpc.vpcmain,
    aws_subnet.public_subnets,   
    aws_security_group.ssh_access, 
  ]    
}

#ssh key from local
resource "aws_key_pair" "testkey" {
  public_key = var.ssh-keyvalue
}

# creating sec. grp.
resource "aws_security_group" "ssh_access" {
    name = "ssh-access"
    vpc_id = aws_vpc.vpcmain.id
    ingress {
        from_port =22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["49.207.210.44/32"]
    } 
    egress {
     from_port       = 0
     to_port         = 0
     protocol        = "-1"
     cidr_blocks     = ["0.0.0.0/0"]
    } 
}

#to get the public ip
output "publicip" {
    value = aws_instance.ec2test.public_ip  
}
