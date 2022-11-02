resource "aws_instance" "Splunk-Server" {
  count = 1
  ami                    = var.ubuntu-ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.dev1-subnet.id
  key_name               = aws_key_pair.lab-key-pair.id
  vpc_security_group_ids = [aws_security_group.splunk.id]
}