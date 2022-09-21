resource "local_file" "module-demo" {
  filename = var.filename
  content  = "Este es mi primer módulo"
}

variable "filename" {
  type = string
}


output "filename" {
  value = local_file.module-demo.filename
}
