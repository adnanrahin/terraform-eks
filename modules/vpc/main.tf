resource "aws_vpc" "main" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.stack_name}/VPC"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.stack_name}/InternetGateway"
  }
}

# Subnets
resource "aws_subnet" "public_useast1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.32.0/19"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name                          = "${var.stack_name}/SubnetPublicUSEAST1A"
    "kubernetes.io/role/elb"      = "1"
  }
}

resource "aws_subnet" "public_useast1c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.0.0/19"
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = true

  tags = {
    Name                          = "${var.stack_name}/SubnetPublicUSEAST1C"
    "kubernetes.io/role/elb"      = "1"
  }
}

resource "aws_subnet" "private_useast1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.96.0/19"
  availability_zone = "${var.region}a"

  tags = {
    Name                              = "${var.stack_name}/SubnetPrivateUSEAST1A"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "private_useast1c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.64.0/19"
  availability_zone = "${var.region}c"

  tags = {
    Name                              = "${var.stack_name}/SubnetPrivateUSEAST1C"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# Route Tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.stack_name}/PublicRouteTable"
  }
}

resource "aws_route_table" "private_useast1a" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.stack_name}/PrivateRouteTableUSEAST1A"
  }
}

resource "aws_route_table" "private_useast1c" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.stack_name}/PrivateRouteTableUSEAST1C"
  }
}

# Routes
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# NAT Gateway Resources
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.stack_name}/NATIP"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_useast1c.id

  tags = {
    Name = "${var.stack_name}/NATGateway"
  }

  depends_on = [aws_internet_gateway.main]
}

resource "aws_route" "private_nat_useast1a" {
  route_table_id         = aws_route_table.private_useast1a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

resource "aws_route" "private_nat_useast1c" {
  route_table_id         = aws_route_table.private_useast1c.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

# Route Table Associations
resource "aws_route_table_association" "public_useast1a" {
  subnet_id      = aws_subnet.public_useast1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_useast1c" {
  subnet_id      = aws_subnet.public_useast1c.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_useast1a" {
  subnet_id      = aws_subnet.private_useast1a.id
  route_table_id = aws_route_table.private_useast1a.id
}

resource "aws_route_table_association" "private_useast1c" {
  subnet_id      = aws_subnet.private_useast1c.id
  route_table_id = aws_route_table.private_useast1c.id
}
