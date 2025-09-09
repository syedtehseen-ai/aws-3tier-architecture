resource "aws_eip" "nateip" {
  for_each = var.public_subnets_ids
  domain       = "vpc"

  tags = merge(
    var.tags,
    { Name = "eip-${each.key}" }
  ) 
}

resource "aws_nat_gateway" "natgw" {
  for_each = var.public_subnets_ids
  allocation_id = aws_eip.nateip[each.key].id 
  subnet_id     = each.value

  tags = {
    Name = "gw-NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.igw_id]
}

