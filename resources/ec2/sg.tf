resource "aws_security_group" "sg" {
  name        = "saju-api-sg-${terraform.workspace}"
  description = "saju api security group ${terraform.workspace}"
  vpc_id      = var.vpc_id

  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "open node port"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "allwo all port & id"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "saju-api-sg-${terraform.workspace}"
    Service = "saju-${terraform.workspace}"
  }

}
