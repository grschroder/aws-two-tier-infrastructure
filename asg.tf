resource "aws_placement_group" "spread-placement-group" {
  name     = "spread-placement-group"
  strategy = "spread"
}

resource "aws_autoscaling_group" "autoscaling-group-app" {
  name                      = "app-asg"
  placement_group           = aws_placement_group.spread-placement-group.name
  min_size                  = 1
  max_size                  = 4
  desired_capacity          = 1
  
  vpc_zone_identifier        = [
    aws_subnet.priv-subnet-app-a.id,
    aws_subnet.priv-subnet-app-b.id
  ]

  launch_template {
    id = aws_launch_template.launch-template-app.id
    version = "$Latest"    
  }

}
