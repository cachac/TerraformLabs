module "network" {
  source       = "./network"
  res_location = lookup(var.location, terraform.workspace, "East US")
  vnet_cidr    = lookup(var.vnet_cidr, terraform.workspace, "10.0.0.0/24")
  subnet_cidr  = lookup(var.subnet_cidr, terraform.workspace, "10.0.0.0/28")
  tags         = var.tags
}

module "infra" {
  source       = "./infra"
  res_location = lookup(var.location, terraform.workspace, "East US")
  vm_size      = lookup(var.vm_size, terraform.workspace, "Standard_B1ls")
  rg_name      = module.network.rg_name
  subnet_id    = module.network.subnet_id
  tags         = var.tags
}
