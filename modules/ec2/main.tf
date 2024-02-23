resource "aws_instance" "pavlo_instance" {
  ami           = "ami-0cac56838ab9419aa" 
  instance_type = "t2.micro"    
  subnet_id     = var.public_subnet_id

  associate_public_ip_address = true

  tags = {
    Name = "PublicEC2"
  }
  security_groups = [var.security_group_id]
}
