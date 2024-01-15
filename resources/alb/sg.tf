resource "aws_security_group" "sg_alb" {
  name        = "saju-alb-sg-${terraform.workspace}"
  description = "saju alb security group ${terraform.workspace}"
  vpc_id      = var.vpc_id

  ingress {
    description = ""
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "saju-alb-sg-${terraform.workspace}"
    Service = "saju-${terraform.workspace}"
  }
}
