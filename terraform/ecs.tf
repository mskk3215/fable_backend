# ----------------------
# Cluster
# ----------------------
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.project}-${var.environment}-cluster"
}
resource "aws_ecs_cluster_capacity_providers" "ecs_cluster_capacity_providers" {
  cluster_name       = aws_ecs_cluster.ecs_cluster.name
  capacity_providers = ["FARGATE"]
  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}
# ----------------------
# Task Definition
# ----------------------
# Frontend
resource "aws_ecs_task_definition" "frontend" {
  family                   = "${var.project}-${var.environment}-frontend-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  cpu                = 1024 # 1 vCPU
  memory             = 3072 # 3GB
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name         = "${var.project}-${var.environment}-frontend-container"
      image        = "${aws_ecr_repository.frontend.repository_url}:latest"
      portMappings = [{ containerPort : 3000 }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region : "ap-northeast-1"
          awslogs-group : aws_cloudwatch_log_group.frontend.name
          awslogs-stream-prefix : "ecs"
        }
      }
      secrets = [
        {
          name : "HOSTNAME"
          valueFrom : data.aws_ssm_parameter.host_name.arn
        },
        {
          name : "NEXT_PUBLIC_BASE_URL"
          valueFrom : data.aws_ssm_parameter.next_public_base_url.arn
        },
      ]
    }
  ])
}

# Backend
resource "aws_ecs_task_definition" "backend" {
  family                   = "${var.project}-${var.environment}-backend-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  cpu                = 1024 # db:seedでのメモリ使用量が多いため、メモリを増やす
  memory             = 3072
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name         = "${var.project}-${var.environment}-backend-container"
      image        = "${aws_ecr_repository.backend.repository_url}:latest"
      portMappings = [{ containerPort : 3001 }]
      secrets = [
        {
          name : "AWS_ACCESS_KEY_ID"
          valueFrom : data.aws_ssm_parameter.aws_access_key_id.arn
        },
        {
          name : "AWS_SECRET_ACCESS_KEY"
          valueFrom : data.aws_ssm_parameter.aws_secret_key.arn
        },
        {
          name : "AWS_BUCKET"
          valueFrom : data.aws_ssm_parameter.aws_bucket.arn
        },
        {
          name : "DB_DATABASE"
          valueFrom : data.aws_ssm_parameter.db_name.arn
        },
        {
          name : "DB_USERNAME"
          valueFrom : data.aws_ssm_parameter.db_username.arn
        },
        {
          name : "DB_PASSWORD"
          valueFrom : data.aws_ssm_parameter.db_password.arn
        },
        {
          name : "DB_HOST"
          valueFrom : aws_ssm_parameter.db_host.arn
        },
        {
          name : "DB_PORT"
          valueFrom : aws_ssm_parameter.db_port.arn
        },
        {
          name : "RAILS_ENV"
          valueFrom : data.aws_ssm_parameter.rails_env.arn
        },
        {
          name : "RAILS_MASTER_KEY"
          valueFrom : data.aws_ssm_parameter.rails_master_key.arn
        },
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region : "ap-northeast-1"
          awslogs-group : aws_cloudwatch_log_group.backend.name
          awslogs-stream-prefix : "ecs"
        }
      }
    },
    {
      name         = "${var.project}-${var.environment}-nginx-container"
      image        = "${aws_ecr_repository.nginx.repository_url}:latest"
      portMappings = [{ containerPort : 80 }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region : "ap-northeast-1"
          awslogs-group : aws_cloudwatch_log_group.backend.name
          awslogs-stream-prefix : "ecs"
        }
      }
    }
  ])
}
# ----------------------
# Service
# ----------------------
# Frontend
resource "aws_ecs_service" "frontend" {
  name                               = "${var.project}-${var.environment}-frontend-service"
  cluster                            = aws_ecs_cluster.ecs_cluster.id
  platform_version                   = "LATEST"
  task_definition                    = "${aws_ecs_task_definition.frontend.family}:${max(aws_ecs_task_definition.frontend.revision, data.aws_ecs_task_definition.frontend.revision)}"
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  propagate_tags                     = "SERVICE"
  enable_execute_command             = true
  launch_type                        = "FARGATE"
  health_check_grace_period_seconds  = 60
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
  network_configuration {
    assign_public_ip = true
    subnets = [
      aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1c.id, aws_subnet.public_subnet_1d.id
    ]
    security_groups = [
      aws_security_group.sg_frontend.id,
    ]
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.alb_tg_frontend.arn
    container_name   = "${var.project}-${var.environment}-frontend-container"
    container_port   = 3000
  }
}

# Backend
resource "aws_ecs_service" "backend" {
  name                               = "${var.project}-${var.environment}-backend-service"
  cluster                            = aws_ecs_cluster.ecs_cluster.id
  platform_version                   = "LATEST"
  task_definition                    = "${aws_ecs_task_definition.backend.family}:${max(aws_ecs_task_definition.backend.revision, data.aws_ecs_task_definition.backend.revision)}"
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  propagate_tags                     = "SERVICE"
  enable_execute_command             = true
  launch_type                        = "FARGATE"
  health_check_grace_period_seconds  = 60
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
  network_configuration {
    assign_public_ip = true
    subnets = [
      aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1c.id, aws_subnet.public_subnet_1d.id
    ]
    security_groups = [
      aws_security_group.sg_backend.id,
    ]
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.alb_tg_backend.arn
    container_name   = "${var.project}-${var.environment}-nginx-container"
    container_port   = 80
  }
}

# ----------------------
# SSM Parameter
# ----------------------
# Frontend
data "aws_ssm_parameter" "host_name" {
  name = "/${var.project}/${var.environment}/frontend/hostname"
}
data "aws_ssm_parameter" "next_public_base_url" {
  name = "/${var.project}/${var.environment}/frontend/NEXT_PUBLIC_BASE_URL"
}
# Backend
data "aws_ssm_parameter" "db_name" {
  name = "/${var.project}/${var.environment}/backend/MYSQL_DATABASE"
}
data "aws_ssm_parameter" "db_username" {
  name = "/${var.project}/${var.environment}/backend/MYSQL_USERNAME"
}
data "aws_ssm_parameter" "db_password" {
  name = "/${var.project}/${var.environment}/backend/MYSQL_PASSWORD"
}
data "aws_ssm_parameter" "db_host" {
  name = "/${var.project}/${var.environment}/backend/MYSQL_HOST"
}
data "aws_ssm_parameter" "db_port" {
  name = "/${var.project}/${var.environment}/backend/MYSQL_PORT"
}
data "aws_ssm_parameter" "aws_access_key_id" {
  name = "/${var.project}/${var.environment}/backend/aws_access_key_id"
}
data "aws_ssm_parameter" "aws_secret_key" {
  name = "/${var.project}/${var.environment}/backend/aws_secret_key"
}
data "aws_ssm_parameter" "aws_bucket" {
  name = "/${var.project}/${var.environment}/backend/aws_bucket"
}
data "aws_ssm_parameter" "rails_env" {
  name = "/${var.project}/${var.environment}/backend/rails_env"
}
data "aws_ssm_parameter" "rails_master_key" {
  name = "/${var.project}/${var.environment}/backend/RAILS_MASTER_KEY"
}
# ----------------------
# data source
# ----------------------
data "aws_ecs_task_definition" "frontend" {
  task_definition = aws_ecs_task_definition.frontend.family
}
data "aws_ecs_task_definition" "backend" {
  task_definition = aws_ecs_task_definition.backend.family
}
# ----------------------
# CloudWatch Log Group
# ----------------------
resource "aws_cloudwatch_log_group" "frontend" {
  name              = "/ecs/${var.project}/frontend/fable-production-frontend-task-definition"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "backend" {
  name              = "/ecs/${var.project}/backend/fable-production-backend-task-definition"
  retention_in_days = 30
}
