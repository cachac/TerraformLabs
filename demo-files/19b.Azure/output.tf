output "vm_public_ip" {
  value = module.infra.public_ip
}

output "vnet_id" {
  value = module.network.vnet_id
}
