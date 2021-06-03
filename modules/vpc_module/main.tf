resource aws_vpc "myvpc"{
	cidr_block = var.vpc_cidr
}
resource aws_subnet "public_subnet"{
	vpc_id = aws_vpc.myvpc.id
	cidr_block = var.public_subnet
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.myvpc.id

}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.myvpc.id
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
}
}
resource "aws_route_table_association" "ra" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt.id
}


output "myoutput"{
value = aws_vpc.myvpc.id
}

output "myoutput1"{
value = aws_subnet.public_subnet.id
}

