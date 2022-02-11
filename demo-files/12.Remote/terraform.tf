terraform {
  required_providers {
    aws = {
      version = "~> 4.0"
    }
  }
  backend "s3" {
    key              = "terraform.tfstate"
    region           = "us-east-1"
    bucket           = "terralabs-remote-state-01" # Nombre del bucket creado en pasos anteriores
    # endpoint         = "http://172.16.238.105:9000"
    # force_path_style = true

    # skip_credentials_validation = true

    # skip_metadata_api_check = true
    # skip_region_validation  = true
  }
}

