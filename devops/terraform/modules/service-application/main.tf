resource "aws_ecs_task_definition" "hello_world" {
  family = "hello_world"
  requires_compatibilities = [
    "fargate"
  ]

  container_definitions = <<EOF
[
  {
    "name": "hello_world",
    "image": "hello-world",
    "cpu": 0,
    "memory": 128,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "ap-southeast-2",
        "awslogs-group": "hello_world",
        "awslogs-stream-prefix": "complete-ecs"
      }
    }
  }
]
EOF
}

resource "aws_ecs_service" "hello_world" {
  name                               = "hello_world"
  cluster                            = var.cluster_id
  task_definition                    = aws_ecs_task_definition.hello_world.arn
  desired_count                      = 1
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
}
