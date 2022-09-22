variable "lab_name" {
	type = string
	description = "Nombre del estudiante"
}
variable "cidr_block" {
	type = string
	description = "Bloque de IP's para la VPC"
}
variable "public_cidr_block" {
	type = string
	description = "Bloque de IP's para la subnet pública"
}
variable "private_cidr_block" {
	type = string
	description = "Bloque de IP's para la subnet privada"
}
variable "public_zone" {
	type = string
	description = "Zona de acceso público"
}
variable "private_zone" {
	type = string
	description = "Zona de acceso privado"
}





