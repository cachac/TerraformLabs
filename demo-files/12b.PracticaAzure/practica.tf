# --- CONFIGURACIÓN DE PROVIDERS ---
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# --- VARIABLES ---

variable "key_name" {
  type        = string
  description = "Nombre que tendrá la llave SSH generada"
}

variable "container_name" {
  type        = string
  description = "Nombre único del storage container (solo minúsculas y números)"
}

variable "student_name" {
  type        = string
  description = "Nombre del estudiante para nombrar la VNet (ej. juan-perez)"
}

# --- INFRAESTRUCTURA: LLAVE SSH ---

# Crear generador de criptografía RSA
resource "tls_private_key" "demo_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Almacenar la llave en un archivo dentro de la máquina local
resource "local_file" "ssh_key_file" {
  content  = tls_private_key.demo_key.private_key_pem
  filename = "${path.module}/${var.key_name}.pem"
}

# --- INFRAESTRUCTURA: AZURE RESOURCE GROUP & STORAGE ---

resource "azurerm_resource_group" "practica_rg" {
  name     = "practica1-resources"
  location = "East US"
}

resource "azurerm_storage_account" "practica_sa" {
  name                     = "practicastorage159325" # Debe ser un valor único sin guiones ni mayúsculas
  resource_group_name      = azurerm_resource_group.practica_rg.name
  location                 = azurerm_resource_group.practica_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "practica_container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.practica_sa.name
  container_access_type = "private" # El acceso a blob o a container explícitamente negado (Privado)
}

# Subir la llave al Blob Storage en la nube
resource "azurerm_storage_blob" "ssh_key_blob" {
  name                   = "${var.key_name}.pem"
  storage_account_name   = azurerm_storage_account.practica_sa.name
  storage_container_name = azurerm_storage_container.practica_container.name
  type                   = "Block"
  source                 = local_file.ssh_key_file.filename
  
  depends_on = [local_file.ssh_key_file]
}

# --- INFRAESTRUCTURA: AZURE VIRTUAL NETWORK ---

resource "azurerm_virtual_network" "practica_vnet" {
  name                = "lab-${var.student_name}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.practica_rg.location
  resource_group_name = azurerm_resource_group.practica_rg.name
}

# --- OUTPUTS ---

output "blob_url" {
  description = "URL del blob que contiene la llave privada SSH"
  value       = azurerm_storage_blob.ssh_key_blob.url
}

output "vnet_id" {
  description = "ID de la Virtual Network recién creada"
  value       = azurerm_virtual_network.practica_vnet.id
}
