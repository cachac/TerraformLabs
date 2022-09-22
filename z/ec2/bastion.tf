resource "aws_instance" "ec2Bastion" {
  instance_type               = "t3a.nano"
  ami                         = data.aws_ami.ubuntu.id
  subnet_id                   = var.public_subnet.id
  # security_groups             = [var.sgBastion.id]
	vpc_security_group_ids      = [var.sgBastion.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2_key.key_name

  tags = {
    Name = "bastion-${var.lab_name}"
  }

  // Opcional:
  provisioner "local-exec" {
    command = <<EOT
  		ssh-keygen -f ~/.ssh/known_hosts -R "${self}"
			chmod 400 "${var.key_name}"
  	EOT
  }
}



