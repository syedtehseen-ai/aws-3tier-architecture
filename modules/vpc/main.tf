resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = true
  region = var.region

  tags = merge(
    var.tags,
    {Name = var.vpctag}
  )
}