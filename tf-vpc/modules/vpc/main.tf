# VPC
resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "my_vpc"
  }
}

# Subnets
resource "aws_subnet" "subnets" {
  count = length(var.subnet_cidrs)

  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.subnet_names[count.index]}-${data.aws_availability_zones.available.names[count.index]}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_igw"
  }
}

# Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0" # All traffic / public 
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "my_rt"
  }
}

# Route Table Association

resource "aws_route_table_association" "rta" {
  count          = length(var.subnet_names)
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.rt.id
}
