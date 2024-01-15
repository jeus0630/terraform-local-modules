resource "aws_lb_target_group" "aws_lb_tg" {
  name     = "saju-tg-${terraform.workspace}"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled  = true
    path     = "/"
    protocol = "HTTP"

    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    matcher             = "200"
  }

  tags = {
    Name    = "saju-tg-${terraform.workspace}"
    Service = "saju-${terraform.workspace}"
  }
}

resource "aws_lb_target_group_attachment" "aws_lb_tg_attachment" {
  count            = length(data.aws_instances.ec2_instances.ids)
  target_group_arn = aws_lb_target_group.aws_lb_tg.arn
  target_id        = element(data.aws_instances.ec2_instances.ids, count.index)
  port             = 3000
}
