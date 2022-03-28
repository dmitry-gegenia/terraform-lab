resource "aws_lb" "lab-nginx-lb" {
  name               = "lan-nginx"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public-sg.id]
  subnets            = [aws_subnet.lab-public-subnet-1.id, aws_subnet.lab-public-subnet-2.id]

  tags = {
    Environment = "Lab"
  }
}

resource "aws_lb_target_group" "lab-nginx-lb-tg" {
  name        = "Lab-nginx-target-group"
  port        = 80
  target_type = "instance"
  vpc_id      = aws_vpc.lab.id
  protocol    = "HTTP"
  health_check {
    enabled  = true
    interval = 10
    port     = 80
    protocol = "HTTP"
    path     = "/"
    matcher  = "200-299"
  }
  tags = {
    Name = "lab-frontend-group"
  }
}

resource "aws_lb_listener" "lab-nginx-lb-l" {
  load_balancer_arn = aws_lb.lab-nginx-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lab-nginx-lb-tg.arn
  }
}

resource "aws_autoscaling_attachment" "nginx-asg-attachment" {
  autoscaling_group_name = aws_autoscaling_group.nginx-asg.id
  lb_target_group_arn    = aws_lb_target_group.lab-nginx-lb-tg.arn
}


#PHP
resource "aws_lb" "lab-php-lb" {
  name               = "lan-php"
  internal           = true
  load_balancer_type = "network"
  #security_groups    = [aws_security_group.private-sg.id]
  subnets = [aws_subnet.lab-private-subnet-1.id, aws_subnet.lab-private-subnet-2.id]

  tags = {
    Environment = "Lab"
  }
}

resource "aws_lb_target_group" "lab-php-lb-tg" {
  name        = "Lab-php-target-group"
  port        = 9000
  target_type = "instance"
  vpc_id      = aws_vpc.lab.id
  protocol    = "TCP"
  #   health_check {
  #     enabled  = true
  #     interval = 10
  #     port     = 80
  #     protocol = "HTTP"
  #     path     = "/"
  #     matcher  = "200-299"
  #   }
  tags = {
    Name = "lab-backend-group"
  }
}

resource "aws_lb_listener" "lab-php-lb-l" {
  load_balancer_arn = aws_lb.lab-php-lb.arn
  port              = "9000"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lab-php-lb-tg.arn
  }
}

resource "aws_autoscaling_attachment" "php-asg-attachment" {
  autoscaling_group_name = aws_autoscaling_group.php-asg.id
  lb_target_group_arn    = aws_lb_target_group.lab-php-lb-tg.arn
}