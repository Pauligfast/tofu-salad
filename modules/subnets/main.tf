resource "aws_subnet" "public_subnet" {
  count                   = 2
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone = element(["eu-central-1a", "eu-central-1b"], count.index)
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr_block

  tags = {
    Name = "pavlo-private-subnet"
  }
}

resource "aws_route_table_association" "subnet_association" {
  count             = length(aws_subnet.public_subnet)
  subnet_id         = aws_subnet.public_subnet[count.index].id
  route_table_id    = var.route_table_id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public_subnet : subnet.id]
}