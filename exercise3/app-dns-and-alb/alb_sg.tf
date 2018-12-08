
resource "aws_security_group" "alb_sg" {
  name = "${local.unique_id}-alb-sg"
  vpc_id = "${data.aws_vpc.vpc.id}"
  tags {
    Name = "${local.unique_id}-alb-sg"
  }
}

resource "aws_security_group_rule" "alb_https_allow_all_traffic" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  from_port = 443
  protocol = "tcp"
  to_port = 443
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_allow_all_egress_traffic" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  from_port = 0
  protocol = "-1"
  to_port = 0
  type = "egress"

  cidr_blocks = ["0.0.0.0/0"]
}