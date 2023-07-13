provider "aws" {}
    

variable avail_zone {}  


variable "cidr_block" {
    description = "cidr blocks and name tags for vpc in subnets"   
    type = list (object({
        cidr_block = string
        name       = string

    }))
    
}

resource "aws_vpc" "development-vpc" {
    cidr_block = var.cidr_block [0].cidr_block
    tags = {
      Name: var.cidr_block [0].name
      
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.cidr_block [1].cidr_block # this is the variable for cidr block 
    availability_zone = var.avail_zone
    tags = {
      Name: var.cidr_block [1].name
    }

}

output "dev-vpc-id" {
    value = aws_vpc.development-vpc.id
    
}

output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-1.id

}


