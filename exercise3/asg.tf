data "aws_subnet_ids" "public_subnet_ids" {
  vpc_id = "${data.aws_vpc.vpc.id}"

  filter {
    name   = "tag:Type"
    values = ["public"]
  }
}

resource "aws_autoscaling_group" "main_asg" {
  name                      = "${local.unique_id}-ecs-cluster-asg"
  availability_zones        = ["us-east-1a", "us-east-1b"]
  vpc_zone_identifier       = ["${data.aws_subnet_ids.public_subnet_ids.ids}"]
  launch_configuration      = "${aws_launch_configuration.ecs-launch-config.id}"
  max_size                  = "1"
  min_size                  = "1"
  desired_capacity          = "1"
  health_check_grace_period = "30"
  health_check_type         = "EC2"
  default_cooldown          = 300
  termination_policies      = ["OldestInstance", "Default"]
  enabled_metrics           = ["${var.asg_enabled_metrics}"]

  tag {
    key                 = "Name"
    value               = "${local.unique_id}-ecs-cluster-asg-instance"
    propagate_at_launch = true
  }
}

variable "asg_enabled_metrics" {
  default = ["GroupStandbyInstances","GroupTotalInstances","GroupPendingInstances","GroupTerminatingInstances",
    "GroupDesiredCapacity","GroupInServiceInstances","GroupMinSize","GroupMaxSize"]
  type = "list"
}



