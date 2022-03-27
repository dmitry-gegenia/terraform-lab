resource "aws_key_pair" "lab-key" {
  key_name   = "lab-key"
  public_key = file("keys/key.pub")
}

resource "aws_launch_template" "lab-nginx-lt" {
  name                                 = "lab-nginx"
  image_id                             = var.instance-image
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.instance-type
  key_name                             = "lab-key"
  #  vpc_security_group_ids               = [aws_security_group.public-sg.id]
  user_data = filebase64("${path.module}/userdata/nginx.sh")
  lifecycle {
    create_before_destroy = true
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.public-sg.id]
    #    subnet_id                   = aws_subnet.name1.id
    delete_on_termination = true
  }
}

resource "aws_autoscaling_group" "nginx-asg" {
  name                = "Lab-nginx-asg"
  min_size            = 1
  max_size            = 5
  desired_capacity    = 1
  vpc_zone_identifier = [aws_subnet.lab-public-subnet-1.id, aws_subnet.lab-public-subnet-2.id]

  launch_template {
    id      = aws_launch_template.lab-nginx-lt.id
    version = "$Latest"
  }
}