resource "aws_s3_bucket" "frontend_bucket" {
  bucket_prefix = "${var.project_name}-frontend-"
  force_destroy = true

  tags = merge(var.tags, {
    Name = "${var.project_name}-frontend"
  })
}

resource "aws_s3_bucket_website_configuration" "frontend_site" {
  bucket = aws_s3_bucket.frontend_bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index_html" {

  bucket = aws_s3_bucket.frontend_bucket.id
  key    = "index.html"

  source       = "${path.module}/../frontend/index.html"
  content_type = "text/html"

}

resource "aws_s3_bucket_policy" "frontend_policy" {

  bucket = aws_s3_bucket.frontend_bucket.id

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = "*"

        Action = [
          "s3:GetObject"
        ]

        Resource = "${aws_s3_bucket.frontend_bucket.arn}/*"
      }
    ]
  })
}