resource "aws_security_group" "sg" {
  name        = "saju-db-sg-${terraform.workspace}"
  description = "saju db security group ${terraform.workspace}"
  vpc_id      = var.vpc_id

  ingress {
    description = "allow 3306 port"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "saju-db-sg-${terraform.workspace}"
    Service = "saju-${terraform.workspace}"
  }

}
