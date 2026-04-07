variable "location" {
  type = map(string)
  default = {
    "default" = "East US"
    "dev"     = "East US"
    "prod"    = "West US"
  }
}

variable "vm_size" {
  type = map(string)
  default = {
    "default" = "Standard_B1ls"
    "dev"     = "Standard_B1ls"
    "prod"    = "Standard_B1s"
  }
}

variable "vnet_cidr" {
  type = map(string)
  default = {
    "default" = "10.0.0.0/24"
    "dev"     = "10.0.0.0/24"
    "prod"    = "10.0.0.0/24"
  }
}

variable "subnet_cidr" {
  type = map(string)
  default = {
    "default" = "10.0.0.0/28"
    "dev"     = "10.0.0.0/28"
    "prod"    = "10.0.0.0/28"
  }
}

variable "tags" {
  type = map(string)
  default = {
    owner = "ESTUDIANTE"
  }
}
