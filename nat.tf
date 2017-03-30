#nat gw 

resource "aws_eip" "nat-eip" { 

vpc = true 

} 

resource "aws_nat_gateway" "nat-gw" { 
 allocation_id =  "${aws_eip.nat-eip.id}"
 subnet_id = "${aws_subnet.main-pub-1.id}"
 depends_on = ["aws_internet_gateway.main-gw"] 

}

resource "aws_route_table" "main-priv-rt" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-gw.id}"

   }
  tags  {
  Name = "main-priv-rt"
  Enviroment = "dev"
   }
}



resource "aws_route_table_association" "main-priv-rt-assc" {
 subnet_id = "${aws_subnet.main-pri-1.id}"
 route_table_id = "${aws_route_table.main-priv-rt.id}"
}  
