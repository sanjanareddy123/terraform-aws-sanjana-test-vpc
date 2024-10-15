output "vpc_id" {
  value = aws_vpc.main.id
}

locals {
  public_subnet_output = {
    for key,config in local.public_subnet : key => {
        subnet_id = aws_subnet.my_subnet[key].id
        azs = aws_subnet.my_subnet[key].availability_zone
    }
  }
}

locals {
  private_subnet_output = {
    for key,config in local.private_subnet : key => {
        subnet_id = aws_subnet.my_subnet[key].id
        azs = aws_subnet.my_subnet[key].availability_zone
    }
  }
}

output "public_subnet_id" {
  value = local.public_subnet_output
}

output "private_subnet_id" {
  value = local.private_subnet_output
}