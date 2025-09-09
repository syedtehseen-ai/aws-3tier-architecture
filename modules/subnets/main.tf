resource "aws_subnet" "pubsubnets" {
  for_each   = var.pubsubnets
  vpc_id     = var.vpc_id
  cidr_block = each.value.cidr
  availability_zone = each.value.pubaz

  tags = merge(
    var.tags,{Name = "${each.key}-subnet"
  }
  )
}

resource "aws_subnet" "pvtsubnets" {
  for_each   = var.pvtsubnets
  vpc_id     = var.vpc_id
  cidr_block = each.value.cidr
  availability_zone = each.value.pvtaz

  tags = merge(
    var.tags,{Name = "${each.key}-subnet"
  }
  )
}