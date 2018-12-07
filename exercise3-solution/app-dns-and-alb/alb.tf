resource "aws_alb" "asgard_alb" {
  name = "${local.unique_id}-asgard-alb"
  internal = false
  security_groups = ["${aws_security_group.alb_sg.id}"]
  subnets = ["${data.aws_subnet_ids.public_subnet_ids.ids}"]

  tags {
    Name = "${local.unique_id}-asgard-alb"
  }
}

resource "aws_alb_listener" "alb_https_listener" {
  load_balancer_arn = "${aws_alb.asgard_alb.arn}"
  port = 443
  protocol = "HTTPS"
  certificate_arn = "${data.aws_acm_certificate.ecsworkshop_cert.arn}"

  "default_action" {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.alb_default_tg.arn}"
  }
}

resource "aws_alb_target_group" "alb_default_tg" {
  name = "${local.unique_id}-default-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = "${data.aws_vpc.vpc.id}"
}


locals {
  
}

data "aws_subnet_ids" "public_subnet_ids" {
  vpc_id = "${data.aws_vpc.vpc.id}"

  filter {
    name   = "tag:Type"
    values = ["public"]
  }
}

data "aws_vpc" "vpc" {

  filter {
    name = "tag:Name"
    values = ["dev-ecs-workshop"]
  }
}

data "aws_acm_certificate" "ecsworkshop_cert" {
  domain      = "*.ecsworkshop2018.online"
  statuses    = ["ISSUED"]
  most_recent = true
}

output "alb_default_tg_arn" {
  value = "${aws_alb_target_group.alb_default_tg.arn}"
}
