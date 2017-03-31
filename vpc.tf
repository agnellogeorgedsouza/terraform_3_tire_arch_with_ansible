resource "aws_vpc" "main-ag" { 

cidr_block = "10.0.0.0/16"
instance_tenancy = "default"
enable_dns_support = "true"
enable_dns_hostnames = "true"
enable_classiclink = "false"
 tags { 
 Name = "main-ag"
 environment = "dev"
 } 

}


#subnets for loadbal , webservers, bastion  

resource "aws_subnet" "main-pub-1" { 
vpc_id = "${aws_vpc.main-ag.id}"
cidr_block = "10.0.1.0/24"
map_public_ip_on_launch = "true"
availability_zone = "ap-southeast-1a"
 tags {
 Name = "main-pub-1"
 environment = "dev"
 }

}


# subnet for database 
# see nat.ft where  we  
resource "aws_subnet" "main-pri-1" {
vpc_id = "${aws_vpc.main-ag.id}"
cidr_block = "10.0.2.0/24"
map_public_ip_on_launch = "false"
availability_zone = "ap-southeast-1b"
 tags {
 Name = "main-pri-1"
 environment = "dev"
 }

}





## IG

resource "aws_internet_gateway" "main-gw" { 
vpc_id = "${aws_vpc.main-ag.id}"
tags  { 
Name = "main-gw"
Enviroment = "dev"
 } 
} 

resource "aws_route_table" "main-pub-rt" { 
  vpc_id = "${aws_vpc.main-ag.id}"
  route { 
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-gw.id}"

   }    
  tags  {
  Name = "main-pub-rt"
  Enviroment = "dev"
   }
} 

## assc subnet to main-pub-rt route table so to make it a public Subnet 

resource "aws_route_table_association" "main-pub-1-rt-assc" { 
 subnet_id = "${aws_subnet.main-pub-1.id}" 
 route_table_id = "${aws_route_table.main-pub-rt.id}"

}  
