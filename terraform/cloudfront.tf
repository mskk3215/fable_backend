# ----------------------
# CloudFront cache distribution
# ----------------------
# CloudFront
resource "aws_cloudfront_distribution" "cf" {
  enabled         = true # 有効かどうか
  is_ipv6_enabled = true # IPv6を有効にするかどうか
  comment         = "cache distribution"
  price_class     = "PriceClass_All"
  http_version    = "http2and3"

  # オリジン
  # ALB用
  origin {
    domain_name = aws_lb.alb.dns_name
    origin_id   = aws_lb.alb.name
    custom_origin_config {
      origin_protocol_policy = "match-viewer" # プロトコルポリシー
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      http_port              = 80
      https_port             = 443
    }
  }
  # S3用
  origin {
    domain_name = aws_s3_bucket.s3_static_bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.s3_static_bucket.id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cf_s3_origin_access_identity.cloudfront_access_identity_path
    }
  }

  # ビヘイビア
  # ALB用
  default_cache_behavior {
    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]
    target_origin_id       = aws_lb.alb.name
    # キャッシュポリシーとオリジンリクエストポリシーを設定
    cache_policy_id          = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }
  
  # S3用
  ordered_cache_behavior {
    path_pattern     = "/uploads/*"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.s3_static_bucket.id #転送先のオリジンID
    cache_policy_id          = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    origin_request_policy_id = "b689b0a8-53d0-40ab-baf2-68738e2966ac"
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true # 圧縮するかどうか
  }
  # アクセス制限
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  aliases = [var.domain]
  # 証明書
  viewer_certificate {
    cloudfront_default_certificate = true                                  # CloudFrontのデフォルト証明書を使用する
    acm_certificate_arn            = aws_acm_certificate.virginia_cert.arn # ACM証明書のARN
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
}

# s3へアクセスする為のオリジンアクセスアイデンティティ
resource "aws_cloudfront_origin_access_identity" "cf_s3_origin_access_identity" {
  comment = "s3 static bucket access identity"
}

# route53 Aレコード(CloudFrontへのルーティングをマッピング用)
resource "aws_route53_record" "route53_a_record_to_cloudfront" {
  zone_id = aws_route53_zone.route53_zone.zone_id
  name    = var.domain
  type    = "A"
  # AWSリソースへのルーティング
  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name    # CloudFrontのdomain名
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id # CloudFrontのZone ID
    evaluate_target_health = false                                         # ターゲットのヘルスチェックを有効にするかどうか
  }
}
# route53 AAAレコード(CloudFrontへのルーティングをマッピング用)
resource "aws_route53_record" "route53_aaa_record_to_cloudfront" {
  zone_id = aws_route53_zone.route53_zone.zone_id
  name    = var.domain
  type    = "AAAA"
  # AWSリソースへのルーティング
  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name    # CloudFrontのdomain名
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id # CloudFrontのZone ID
    evaluate_target_health = false                                         # ターゲットのヘルスチェックを有効にするかどうか
  }
}
