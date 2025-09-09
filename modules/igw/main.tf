resource "aws_internet_gateway" "internetgw" {
  vpc_id = var.vpc_id
  region = var.region

  tags = merge(
    var.tags,{Name = var.igw_name}
  )
}