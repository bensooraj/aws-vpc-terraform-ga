module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  subnet_cidrs = var.subnet_cidrs
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}