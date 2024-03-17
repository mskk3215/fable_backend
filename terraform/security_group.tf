# ----------------------
# Security Group
# ----------------------
# ALB security group
resource "aws_security_group" "sg_alb" {
  name        = "${var.project}-${var.environment}-sg-alb"
  description = "ALB security group"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name    = "${var.project}-${var.environment}-sg-alb"
    Project = var.project
    Env     = var.environment
  }
}
# ALB security group rule
resource "aws_security_group_rule" "alb_in_https" {
  security_group_id = aws_security_group.sg_alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "alb_out" {
  security_group_id = aws_security_group.sg_alb.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}


# frontend security group
resource "aws_security_group" "sg_frontend" {
  name        = "${var.project}-${var.environment}-sg-frontend"
  description = "frontend role security group"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name    = "${var.project}-${var.environment}-sg-frontend"
    Project = var.project
    Env     = var.environment
  }
}
# frontend security group rule
resource "aws_security_group_rule" "frontend_in" {
  security_group_id        = aws_security_group.sg_frontend.id
  type                     = "ingress" # ingress: インバウンド, egress: アウトバウンド
  protocol                 = "tcp"
  from_port                = 3000
  to_port                  = 3000
  source_security_group_id = aws_security_group.sg_alb.id # ALBからのトラフィックを許可
}
resource "aws_security_group_rule" "frontend_out" {
  security_group_id = aws_security_group.sg_frontend.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}


# backend security group
resource "aws_security_group" "sg_backend" {
  name        = "${var.project}-${var.environment}-sg-backend"
  description = "backend role security group"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name    = "${var.project}-${var.environment}-sg-backend"
    Project = var.project
    Env     = var.environment
  }
}
# backend security group rule
resource "aws_security_group_rule" "backend_in" {
  security_group_id        = aws_security_group.sg_backend.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.sg_alb.id # ALBからのトラフィックを許可
}
resource "aws_security_group_rule" "backend_out" {
  security_group_id = aws_security_group.sg_backend.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

# db security group
resource "aws_security_group" "sg_db" {
  name        = "${var.project}-${var.environment}-sg-db"
  description = "database role security group"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name    = "${var.project}-${var.environment}-sg-db"
    Project = var.project
    Env     = var.environment
  }
}
# db security group rule
resource "aws_security_group_rule" "db_in_from_frontend" {
  security_group_id        = aws_security_group.sg_db.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.sg_frontend.id # frontendからのトラフィックを許可
}
resource "aws_security_group_rule" "db_in_from_backend" {
  security_group_id        = aws_security_group.sg_db.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.sg_backend.id # backendからのトラフィックを許可
}
resource "aws_security_group_rule" "db_out" {
  security_group_id = aws_security_group.sg_db.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}
