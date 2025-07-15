resource "aws_vpc" "automated1" {
  cidr_block = var.vpc_cidr
  tags = {
    name= "automated"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.automated1.id

  tags = {
    name= "igw"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.automated1.id
  route {
    cidr_block= var.rt_cidr
    gateway_id= aws_internet_gateway.igw.id

  }

  tags = {
    name= "rt"
  }
}


resource "aws_route_table_association" "rta" {
  subnet_id = aws_subnet.publicsubnet.id
  route_table_id = aws_route_table.rt.id

}


resource "aws_subnet" "publicsubnet" {
  vpc_id = aws_vpc.automated1.id
  cidr_block = var.subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    name="publicsubnet"
  } 

}

resource "aws_security_group" "secgrp" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id = aws_vpc.automated1.id
 tags = {
    Name = "allow_tls"
  }
}
resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  security_group_id = aws_security_group.secgrp.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.sec_cider]
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  security_group_id = aws_security_group.secgrp.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [var.sec_cider]
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.secgrp.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


resource "aws_instance" "wordpressserver" {
  ami               = var.ami
  instance_type     = "t3.micro"
  subnet_id         = aws_subnet.publicsubnet.id
  availability_zone = var.availability_zone
  vpc_security_group_ids = [aws_security_group.secgrp.id]
  tags = {
    Name = "wordpressserver"
  }
}


