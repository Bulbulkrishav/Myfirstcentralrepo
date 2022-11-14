# creating VPC, name, CIDR and Tags
resource "aws_vpc" "bulbul" {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags = {
        Name = "bulbul"
    }
}
# creating subnets
resource "aws_subnet" "public-sub-1" {
    vpc_id     = aws_vpc.bulbul.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
    tags = {
        Name = "public-sub-1"
    }
}

resource "aws_subnet" "public-sub-2" {
    vpc_id     = aws_vpc.bulbul.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"
    tags = {
        Name = "public-sub-2"
    }
}

# creating internet gateway
resource "aws_internet_gateway" "bulbul-gw" {
    vpc_id = aws_vpc.bulbul.id

    tags = {
        Name = "bulbul-gw"
    }
}
# creating route tables
resource "aws_route_table" "bulbul-RT" {
    vpc_id = aws_vpc.bulbul.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.bulbul-gw.id
    }
    
    tags = {
        Name = "public-sub-1"
    }
}
    # creating route association public subnets
resource "aws_route_table_association" "public-sub-1-a" {
    subnet_id      = aws_subnet.public-sub-1.id
    route_table_id = aws_route_table.bulbul-RT.id
}

resource "aws_route_table_association" "public-sub-2-a" {
    subnet_id      = aws_subnet.public-sub-2.id
    route_table_id = aws_route_table.bulbul-RT.id
}

#creating EC2 
resource "aws_instance" "Demo" {
    ami   = "ami-0c4e4b4eb2e11d1d4"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.public-sub-1.id}"
    key_name = "linuxpractice"
    tags = {
        Name = "Demo"
    }
}

resource "aws_instance" "Demo-1" {
    ami   = "ami-0c4e4b4eb2e11d1d4"
    instance_type = "t2.micro"
        subnet_id = "${aws_subnet.public-sub-2.id}"
    key_name = "linuxpractice"
    tags = {
        Name = "Demo-1"
    }
}