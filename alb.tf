resource "aws_lb" "alb" {
  name                       = "alb-app"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = [
    aws_subnet.public-subnet-a.id,
    aws_subnet.public-subnet-b.id
  ]
  security_groups            = [ 
    aws_security_group.allow_tls.id,
    aws_security_group.allow_http.id
  ]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "alb-app-tg" {
  name        = "alb-app-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.VPC_ID

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "80"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }
}

resource "aws_lb_listener" "alb-app-listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-app-tg.arn
  }
}

resource "aws_autoscaling_attachment" "alb-asg-app-attachment" {
  autoscaling_group_name = aws_autoscaling_group.autoscaling-group-app.name
  lb_target_group_arn    = aws_lb_target_group.alb-app-tg.arn
}