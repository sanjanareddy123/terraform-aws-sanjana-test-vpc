resource "aws_vpc" "main" {
  cidr_block = var.vpc_config.cidr_block
  tags = {
    name= var.vpc_config.name
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id = aws_vpc.main.id
  for_each = var.subnets_config
  cidr_block = each.value.cidr_block
  availability_zone = each.value.azs


  tags = {
    name = each.key
  }
}

locals {
  public_subnet = {
    for key,config in var.subnets_config : key => config if config.public
  }
}

locals {
  private_subnet = {
    for key,config in var.subnets_config : key => config if !config.public
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  count = length(local.public_subnet)>0 ? 1 : 0
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  count = length(local.public_subnet)>0 ? 1 : 0
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }

}
 
resource "aws_route_table_association" "main" {
    for_each = local.public_subnet
  route_table_id = aws_route_table.main[0].id
  subnet_id = aws_subnet.my_subnet[each.key].id
}