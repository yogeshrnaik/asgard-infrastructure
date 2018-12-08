locals {
  unique_id = "yogesh"
}

resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${local.unique_id}-ecs-cluster"
}

data "aws_subnet" "public_subnet" {
  filter {
    name   = "tag:Name"
    values = ["dev-ecs-workshop-public-subnet-0"]
  }
  vpc_id = "${data.aws_vpc.vpc.id}"
}

resource "aws_launch_configuration" "ecs-launch-config" {
  image_id             = "ami-07eb698ce660402d2"
  instance_type        = "t3.micro"
  iam_instance_profile = "${aws_iam_instance_profile.ecs_cluster_instance_profile.name}"

  security_groups = [ "${aws_security_group.ecs-instance-security.id}" ]

  name_prefix = "${local.unique_id}-lc"
  # [TODO] NOTE: ECSAutoScalingGroup - IS Refered from the CloudFormation template for autoscaling group.
  user_data = <<-EOF
              #!/bin/bash
              cat <<'CONFIG' >> /etc/ecs/ecs.config
              ECS_CLUSTER=${aws_ecs_cluster.ecs-cluster.name}
              ECS_ENABLE_TASK_IAM_ROLE=true
              ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true
              CONFIG
              EOF

  lifecycle = {
    create_before_destroy = "true"
  }

  root_block_device {
    // Recommended for ECS AMI https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-ami-storage-config.html
    volume_size           = "30"
    delete_on_termination = true
  }
}

