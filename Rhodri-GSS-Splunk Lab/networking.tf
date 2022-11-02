resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "development"
  }
}

# Subnets have to be allowed to automatically map public IP addresses for worker nodes
resource "aws_subnet" "dev1-subnet" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = var.dev1_subnet_cidr_block
  availability_zone       = var.dev1_subnet_az
  map_public_ip_on_launch = true

  tags = {
    Name                                        = "dev1-subnet"
   
  }
}

resource "aws_subnet" "dev2-subnet" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = var.dev2_subnet_cidr_block
  availability_zone       = var.dev2_subnet_az
  map_public_ip_on_launch = true

  tags = {
    Name                                        = "dev2-subnet"
  }
}

resource "aws_internet_gateway" "dev-gw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name = "dev-gw"
  }
}

resource "aws_route_table" "dev-route-table" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.dev-gw.id
  }


  tags = {
    Name = "dev-rt"
  }
}

resource "aws_route_table_association" "dev1-sub-to-dev-rt" {
  subnet_id      = aws_subnet.dev1-subnet.id
  route_table_id = aws_route_table.dev-route-table.id
}

resource "aws_route_table_association" "dev2-sub-to-dev-rt" {
  subnet_id      = aws_subnet.dev2-subnet.id
  route_table_id = aws_route_table.dev-route-table.id
}