variable "name" {
  type        = string
  description = "Nombre de la instancia"

  validation {
    condition     = length(var.name) > 5
    error_message = "El nombre de la instancias debe ser mayor a 5 caracteres."
  }
}
variable "size" {
  type        = string
  description = "Tamaño de la instancia: small - large"

  validation {
    condition     = var.size == "nano" || var.size == "micro"
    error_message = "Las instancias permitidas son: nano || micro."
  }
}
variable "nano" {
  type    = string
  default = "t3a.nano"
}
variable "micro" {
  type    = string
  default = "t3a.micro"
}


resource "aws_instance" "server" {
  ami           = "ami-033b95fb8079dc481"
  instance_type = var.size == "nano" ? var.nano : var.micro
  tags = {
    Name = var.name
  }
}
output "instance_size" {
  value = aws_instance.server.instance_type
}



provider "aws" {
  region = "us-east-1"
}
