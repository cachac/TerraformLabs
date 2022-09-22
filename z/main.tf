module "network" {
  source = "./network"

  lab_name           = var.lab_name
  cidr_block         = var.cidr_block
  public_cidr_block  = var.public_cidr_block
  private_cidr_block = var.private_cidr_block
  public_zone        = var.public_zone
  private_zone       = var.private_zone
}

module "security_groups" {
  source = "./securityGrops"

  vpc = module.network.vpc
}

module "ec2" {
  source = "./ec2"

  lab_name      = var.lab_name
  public_subnet = module.network.public_subnet
  sgBastion     = module.security_groups.sgBastion
  key_name      = var.key_name
}
