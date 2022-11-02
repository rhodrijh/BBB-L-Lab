
resource "tls_private_key" "lab-key-pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "lab-key-pair" {
  key_name   = var.key_name
  public_key = tls_private_key.lab-key-pair.public_key_openssh
}

#########################################
####FLIP SENSATIVE TO TRUE EVENTUALLY####
#########################################

output "private_key" {
  value     = tls_private_key.lab-key-pair.private_key_pem
  sensitive = true
}