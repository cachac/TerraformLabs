locals {
  filename = "test.txt"
}

module "file-module" {
  source = "./file-module"
  filename = local.filename

}

module "file-module-dos" {
  source = "./file-module"

  filename = "dos.txt"
}

output "archivo" {
  value       = module.file-module.filename
}

output "archivo-dos" {
  value       = module.file-module-dos.filename
}
