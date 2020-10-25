data "aws_iam_role" "task_execution_role" {
  name = "ecsTaskExecutionRole"
}

data "template_file" "hello_world" {
  template = "${file("${path.module}/tasks/hello-world.json")}"
  vars = {

  }
}

resource "aws_ecs_task_definition" "hello_world" {
  family = "hello_world"
  requires_compatibilities = [
    "FARGATE"
  ]

  execution_role_arn = data.aws_iam_role.task_execution_role.arn

  cpu          = "256"
  memory       = "512"
  network_mode = "awsvpc"

  container_definitions = data.template_file.hello_world.rendered
}

resource "aws_security_group" "hello_world_task" {
  name        = "${var.name}-esc-hello-world-task"
  description = "Allow inbound access"
  vpc_id      = var.vpc

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}

resource "aws_ecs_service" "hello_world" {
  name            = "hello_world"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.hello_world.arn

  launch_type = "FARGATE"

  desired_count                      = 1
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
  network_configuration {
    subnets          = []
    security_groups  = [aws_security_group.hello_world_task.id]
    assign_public_ip = true

  }
  tags = var.tags
}
