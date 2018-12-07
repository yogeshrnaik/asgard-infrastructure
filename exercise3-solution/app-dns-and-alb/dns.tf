module "asgard-dns" {
  source = "../route53"
  lb_zone_id = "${aws_alb.asgard_alb.zone_id}"
  app_name = "${local.unique_id}-asgard"
  dns_record_set_name = "${local.unique_id}.ecsworkshop2018.online"
  weight = "100"
  env = "dev"
  hosted_zone = "${data.aws_route53_zone.ecsworkshop_hosted_zone.name}"
  lb_dns_name = "${aws_alb.asgard_alb.dns_name}"
}

data "aws_route53_zone" "ecsworkshop_hosted_zone" {
  name = "ecsworkshop2018.online."
}
