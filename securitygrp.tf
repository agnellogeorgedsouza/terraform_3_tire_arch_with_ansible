resource "aws_security_group" "allowPort80" { 

 vpc_id = "${aws_vpc.main.id}"
 name = "allowPort80"
 description = "allow port 80"
 egress { 
  from_port = 0 
  to_port = 0 
  protocol = -1 
  cidr_blocks = ["0.0.0.0/0"] 
 } 
 ingress { 
  from_port = 80 
  to_port =  80 
  protocol = "tcp" 
  cidr_blocks = ["123.201.40.36/32"] 
 } 

 ingress { 
  from_port = 80
  to_port =  80
  protocol = "tcp" 
  cidr_blocks = ["10.0.0.0/16"] 
 }
 
}

resource "aws_security_group" "allowPort22" {

 vpc_id = "${aws_vpc.main.id}"
 name = "allowPort22"
 description = "allow port 22"
 
 egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }

ingress { 
  from_port = 22 
  to_port =  22
  protocol = -1 
  cidr_blocks = ["123.201.40.36/32"] 
 } 
 ingress { 
  from_port = 22 
  to_port =  22
  protocol = -1 
  cidr_blocks = ["10.0.0.0/16"] 
 } 
 tags { 
  Name = "allowPort22"
  enviroment = "dev" 
 } 

}

resource "aws_security_group" "allowPort3306" {
 vpc_id = "${aws_vpc.main.id}"
 name = "allowPort3306"
 description = "allow port 3306 "
 
 egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }
 
 ingress {
  from_port = 3306
  to_port =  3306
  protocol = "tcp"
  cidr_blocks = ["123.201.40.36/32"]
 } 
 ingress {
  from_port = 3306
  to_port =  3306
  protocol = "tcp"
  cidr_blocks = ["10.0.0.0/16"]
 }
 tags {
  Name = "allowPort3306"
  enviroment = "dev"
 }

} 
