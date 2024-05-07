module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  subnet_cidrs = var.subnet_cidrs
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2"
  sg_id = module.sg.sg_id
  subnet_ids = module.vpc.subnet_ids
}

module "alb" {
  source = "./modules/alb"
  sg_id = module.sg.sg_id
  subnet_ids = module.vpc.subnet_ids
  vpc_id = module.vpc.vpc_id
  instance_ids = module.ec2.instance_ids
}