# S3 bucket名用のランダム文字列生成
resource "random_string" "s3_unique_key" {
  length  = 6
  upper   = false #大文字を含めるか
  lower   = true  #小文字を含めるか
  numeric = true  #数字を含めるか
  special = false #特殊文字を含めるか
}
# ----------------------
# S3 static bucket
# ----------------------
resource "aws_s3_bucket" "s3_static_bucket" {
  bucket = "${var.project}-${var.environment}-static-bucket-${random_string.s3_unique_key.result}"
}
# バージョニング
resource "aws_s3_bucket_versioning" "s3_static_bucket_versioning" {
  bucket = aws_s3_bucket.s3_static_bucket.id
  versioning_configuration {
    status = "Disabled"
  }
}
# パブリックアクセスブロック
resource "aws_s3_bucket_public_access_block" "s3_static_bucket" {
  bucket                  = aws_s3_bucket.s3_static_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  depends_on = [
    aws_s3_bucket_policy.s3_static_bucket,
  ]
}
# バケットポリシー
resource "aws_s3_bucket_policy" "s3_static_bucket" {
  bucket = aws_s3_bucket.s3_static_bucket.id
  policy = data.aws_iam_policy_document.s3_static_bucket.json
}
# バケットポリシードキュメント
data "aws_iam_policy_document" "s3_static_bucket" {
  statement {
    effect = "Allow"
    # アクションリスト
    actions = [
      "s3:PutObject",
      "s3:DeleteObject",
    ]
    # 処理対象のリソース
    resources = [
      "${aws_s3_bucket.s3_static_bucket.arn}/*"
    ]
    # 関連づけるエンティティ
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.ecs_task_execution_role.arn]
    }
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.s3_static_bucket.arn}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.cf_s3_origin_access_identity.iam_arn]
    }
  }
}
