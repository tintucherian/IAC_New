variable "ami" {
    default = "ami-0376ec8eacdf70aae"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "public_subnet_cidr" { 
 default     = "10.0.1.0/24"
}

# variable "private_subnet_cidr" { 
#  default     = "10.0.2.0/24"
# }

variable "availability_zone" { 
 default     = "ap-south-1b"
}

variable "ssh-keyvalue" {

}

 # variable "IPvalue" {

 # }