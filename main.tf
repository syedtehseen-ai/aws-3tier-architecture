############################################################
#  VPC Module
############################################################
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr = var.vpc_cidr
  tags     = var.tags
  vpctag   = var.vpctag
  region   = var.region
}

############################################################
# Internet Gateway Module
############################################################
module "igw" {
  source = "./modules/igw"

  vpc_id   = module.vpc.vpc_id
  igw_name = var.igw_name
  region   = var.region
  tags     = var.tags
}

############################################################
# NAT Gateway Module
############################################################
module "natgw" {
  source             = "./modules/natgw"
  public_subnets_ids = module.subnets.public_subnets_ids
  igw_id             = module.igw.igw_id
  tags               = var.tags
}

############################################################
# Subnets Module
############################################################
module "subnets" {
  source     = "./modules/subnets"
  pubsubnets = var.pubsubnets
  pvtsubnets = var.pvtsubnets
  #natgw_by_az = var.natgw_by_az
  vpc_id = module.vpc.vpc_id
  tags   = var.tags
}

############################################################
# Route Tables Module
############################################################
module "route_tables" {
  source                   = "./modules/route-tables"
  vpc_id                   = module.vpc.vpc_id
  igw_id                   = module.igw.igw_id
  natgw_id                 = module.natgw.natgw_id
  public_subnets_ids       = module.subnets.public_subnets_ids  # list of public subnet IDs
  private_subnets_ids      = module.subnets.private_subnets_ids # list of private subnet IDs
  private_subnet_natgw_map = var.private_subnet_natgw_map       # from dev.tfvars
  tags                     = var.tags
}
