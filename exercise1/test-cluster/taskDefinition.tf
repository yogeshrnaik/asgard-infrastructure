terraform {
  required_version = "= 0.11.10"

    backend "s3" {
      region     = "us-east-1"
      bucket     = "ecs-workshop-terraform-state-dev"
      key        = "yogesh-cluster-test-nginx.tfstate"
      encrypt    = "true"
      dynamodb_table = "Terraform-Lock-Table"
    }
}

provider "aws" {
  region = "us-east-1"
  version = "~> 1.46"
}


resource "aws_ecs_task_definition" "nginx-service" {
  family                = "nginx-service"
  container_definitions = "${file("nginx-ecs-task-definition.json")}"
}


data "aws_ecs_cluster" "vtw-dev-ecs-cluster" {
  cluster_name = "${var.cluster_name}"
}

resource "aws_ecs_service" "nginx-service" {
  name            = "nginx-service"
  cluster         = "${data.aws_ecs_cluster.vtw-dev-ecs-cluster.cluster_name}"
  task_definition = "${aws_ecs_task_definition.nginx-service.arn}"
  desired_count   = 1
}
