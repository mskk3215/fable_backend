# ----------------------
# ALB
# ----------------------
# ロードバランサー
resource "aws_lb" "alb" {
  name               = "${var.project}-${var.environment}-alb"
  internal           = false #内部むけかどうか
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_alb.id]
  subnets = [
    aws_subnet.public_subnet_1a.id,
    aws_subnet.public_subnet_1c.id,
    aws_subnet.public_subnet_1d.id
  ]
}

# HTTPSリスナー
resource "aws_lb_listener" "alb_listener_https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.tokyo_cert.arn # 証明書のARN
  # デフォルトのリスナールール
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_frontend.arn
  }
}
# HTTPSリスナールール
resource "aws_lb_listener_rule" "https_rule_backend" {
  listener_arn = aws_lb_listener.alb_listener_https.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_backend.arn
  }
  condition {
    path_pattern {
      values = ["/api/v1/*"]
    }
  }
}

# ----------------------
# target group
# ----------------------
# target group
resource "aws_lb_target_group" "alb_tg_backend" {
  name        = "${var.project}-${var.environment}-tg-backend"
  target_type = "ip"

  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  health_check {
    enabled             = true
    interval            = 30               # ヘルスチェックの間隔（秒）
    path                = "/api/v1/health" # ヘルスチェックのパス
    port                = "traffic-port"   # ヘルスチェックのポート
    healthy_threshold   = 5                # 健全とみなされるまでの連続した正常なヘルスチェックの回数
    unhealthy_threshold = 2                # 異常とみなされるまでの連続した異常なヘルスチェックの回数
    timeout             = 5                # レスポンスのタイムアウト（秒）
    matcher             = "200-399"        # レスポンスが正常とみなされるステータスコード範囲
  }
  tags = {
    Name    = "${var.project}-${var.environment}-tg-backend"
    Project = var.project
    Env     = var.environment
  }
}
resource "aws_lb_target_group" "alb_tg_frontend" {
  name        = "${var.project}-${var.environment}-tg-frontend"
  target_type = "ip"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name    = "${var.project}-${var.environment}-tg-frontend"
    Project = var.project
    Env     = var.environment
  }
}
