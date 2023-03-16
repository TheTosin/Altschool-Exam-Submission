#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "Altschool" {
  cidr_block = "10.0.0.0/16"

  tags = tomap({
    "Name"                                      = "terraform-eks-Altschool-node",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
  })
}

resource "aws_subnet" "Altschool" {
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.Altschool.id

  tags = tomap({
    "Name"                                      = "terraform-eks-Altschool-node",
    "kubernetes.io/cluster/${var.cluster_name}" =  "shared",
  })
}

resource "aws_internet_gateway" "Altschool" {
  vpc_id = aws_vpc.Altschool.id

  tags = {
    Name = "terraform-eks-Altschool"
  }
}

resource "aws_route_table" "Altschool" {
  vpc_id = aws_vpc.Altschool.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Altschool.id
  }
}

resource "aws_route_table_association" "Altschool" {
  count = 2

  subnet_id      = aws_subnet.Altschool.*.id[count.index]
  route_table_id = aws_route_table.Altschool.id
}

