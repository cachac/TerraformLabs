resource "tls_private_key" "privateKey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key" {
  key_name   = var.key_name
  public_key = tls_private_key.privateKey.public_key_openssh
}

resource "local_file" "key_file" {
  content         = tls_private_key.privateKey.private_key_pem
  filename        = "key.pem"
  file_permission = "0400"
}



