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
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  skip_destroy             = var.skip_destroy
  track_latest             = var.track_latest
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

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

resource "aws_ecs_service" "ecs_service" {
  name                               = "ecs_service"
  cluster                            = aws_ecs_cluster.ecs_cluster.arn
  availability_zone_rebalancing      = "ENABLED"
  deployment_maximum_percent         = var.max_percent # FOR ZERO DOWNTIME
  deployment_minimum_healthy_percent = var.min_percent  # AND FOR ROLLING UPDATES
  desired_count                      = var.desired_count
  enable_ecs_managed_tags            = true
  enable_execute_command             = true
  force_delete                       = true
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
  launch_type                        = var.launch_type # SERVERLESS
  platform_version                   = var.platform_version
  propagate_tags                     = "SERVICE" # COPY TAGS FROM THE SERVICE CODE SNIPPET
  task_definition                    = aws_ecs_task_definition.task_definition.arn

  load_balancer {
    target_group_arn = module.alb.target_arn
    container_name   = "Web-Application"
    container_port   = 8080
  }

  network_configuration {
    subnets          = module.vpc.private_subnet_ids
    security_groups  = [module.security_group.private_sg_id]
    assign_public_ip = false # FOR PRIVATE 
  }
}