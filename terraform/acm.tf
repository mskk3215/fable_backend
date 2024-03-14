# ----------------------
# Certificate
# ----------------------
# For Tokyo Region
# SSL/TLS証明書作成
resource "aws_acm_certificate" "tokyo_cert_host" {
  domain_name       = var.domain
  validation_method = "DNS"
  tags = {
    Name    = "${var.project}-${var.environment}-wildcard-sslcert"
    Project = var.project
    Env     = var.environment
  }
  lifecycle {
    create_before_destroy = true # 削除前に作成
  }
  depends_on = [aws_route53_zone.route53_zone]
}
resource "aws_acm_certificate" "tokyo_cert_sub" {
  domain_name       = "*.${var.domain}"
  validation_method = "DNS"
  tags = {
    Name    = "${var.project}-${var.environment}-wildcard-sslcert"
    Project = var.project
    Env     = var.environment
  }
  lifecycle {
    create_before_destroy = true # 削除前に作成
  }
  depends_on = [aws_route53_zone.route53_zone]
}

# Route53 CNAMEレコード(SSL/TLS証明書のドメイン検証用)CA提供の情報をレコードとして追加することで証明
resource "aws_route53_record" "route53_acm_dns_resolve" {
  for_each = {
    for dvo in aws_acm_certificate.tokyo_cert_host.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }
  allow_overwrite = true
  zone_id         = aws_route53_zone.route53_zone.id
  name            = each.value.name     # レコード名
  type            = each.value.type     # レコードタイプ
  ttl             = 600                 # キャッシュの有効期限
  records         = [each.value.record] # 転送先DNS名
}

# SSL/TLS証明書検証(証明書が正しく発行されたことを確認)
resource "aws_acm_certificate_validation" "cert_valid" {
  certificate_arn         = aws_acm_certificate.tokyo_cert_host.arn
  validation_record_fqdns = [for record in aws_route53_record.route53_acm_dns_resolve : record.fqdn]
}

# For US East (N. Virginia) Region(CloudFront用)
resource "aws_acm_certificate" "virginia_cert" {
  provider          = aws.virginia #デフォルトのプロバイダーを上書き
  domain_name       = "*.${var.domain}"
  validation_method = "DNS"
  tags = {
    Name    = "${var.project}-${var.environment}-wildcard-sslcert"
    Project = var.project
    Env     = var.environment
  }
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [aws_route53_zone.route53_zone]
}
