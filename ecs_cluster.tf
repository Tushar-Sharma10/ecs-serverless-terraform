resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  family = "HelloWorld"
  container_definitions = jsonencode([
    {
      name      = "Web-application"
      image     = "tusharsharma01/web-app:latest"
      essential = true

      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]
      mountPoints = [
        {
          sourceVolume  = "EFSvolume"
          containerPath = "/mnt/data"
          readOnly      = false
        }
      ]
      healthCheck = {
        command     = ["CMD-SHELL", "curl -f http://localhost:8080/ || exit 1"]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 10
      }

      environment = [
        { name = "APP_ENV", value = "production" },
        { name = "LOG_LEVEL", value = "info" }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/hello-world"
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
  requires_compatibilities = [var.requires_compatibilities]
  cpu                      = "100"
  memory                   = "100"
  network_mode             = "awsvpc"
  skip_destroy             = var.skip_destroy
  track_latest             = var.track_latest

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "x86_64"
  }
  volume {
    name = var.volume_name
    efs_volume_configuration {
      file_system_id          = aws_efs_file_system.efs.id
      root_directory          = "/"
      transit_encryption      = "ENABLED"
      transit_encryption_port = 2049
    }
  }
}
