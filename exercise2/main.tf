locals {
  unique_id = "ecs-workshop"
}

resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${local.unique_id}-ecs-cluster"
}

resource "aws_instance" "cluster-ec2-instance" {
  ami = "ami-07eb698ce660402d2"
  instance_type = "t3.micro"
  iam_instance_profile = "${aws_iam_instance_profile.ecs_cluster_instance_profile.name}"
  security_groups = ["${aws_security_group.ecs-instance-security.id}"]

  user_data = <<EOF
    cat <<'CONFIG' >> /etc/ecs/ecs.config
    ECS_CLUSTER=${aws_ecs_cluster.ecs-cluster.name}
    ECS_ENABLE_TASK_IAM_ROLE=true
    ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true
    CONFIG
  EOF

  root_block_device {
    volume_size = "30"
    delete_on_termination = true
  }

  tags {
    Name = "${local.unique_id}-ecs-cluster-instance"
  }
}
