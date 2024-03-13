resource "aws_lb" "pavlo_lb" {
  name               = "pavlo-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [var.security_group_id]
}

resource "aws_lb_target_group" "pavlo_lb_target_group" {
  name     = "pavlo-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "pavlo_listener" {
  load_balancer_arn = aws_lb.pavlo_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pavlo_lb_target_group.arn
  }
}

resource "aws_launch_configuration" "pavlo_launch_config" {
  name          = "pavlo-launch-config"
  image_id      = "ami-0cac56838ab9419aa"
  instance_type = "t2.micro"
  security_groups = [var.security_group_id]
  associate_public_ip_address = true

  user_data = file("../../modules/ec2/user-data/ec2-entrypoint.sh")
}

resource "aws_autoscaling_group" "pavlo_autoscaling_group" {
  name                 = "pavlo-asg"
  min_size             = 3
  max_size             = 3
  desired_capacity     = 3
  vpc_zone_identifier  = var.public_subnet_ids

  launch_configuration = aws_launch_configuration.pavlo_launch_config.name

  tag {
    key                 = "Pavlo"
    value               = "pavlo_autoscaling_group-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "pavlo_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.pavlo_autoscaling_group.name
  lb_target_group_arn = aws_lb_target_group.pavlo_lb_target_group.arn
}
