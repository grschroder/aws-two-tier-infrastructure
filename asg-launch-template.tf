resource "aws_launch_template" "launch-template-app" {
  name_prefix   = "app-asg-"
  image_id      = data.aws_ami.ami-ubuntu22-server.id
  instance_type = "t3.medium"
  key_name      = var.SSH_KEY_NAME
  user_data     = filebase64("app-userdata.sh")

  vpc_security_group_ids = [
    aws_security_group.allow_tls.id,
    aws_security_group.allow_http.id,
    var.SG_ALLOW_SSH
  ]  

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "app-instance"
    }
  }
  
  lifecycle {
    create_before_destroy = true
  }
}