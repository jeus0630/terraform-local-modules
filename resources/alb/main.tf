resource "aws_lb" "alb" {
  name               = "saju-alb-${terraform.workspace}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_alb.id]
  subnets            = concat(var.public_subnet_id, var.private_subnet_id)

  enable_deletion_protection = false

  tags = {
    Name = "saju-${terraform.workspace}"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws_lb_tg.arn
  }
}
