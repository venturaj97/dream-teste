resource "aws_s3_bucket" "job_bucket" {
  bucket_prefix = "${var.project_name}-job-"
  force_destroy = true

  tags = merge(var.tags, {
    Name = "${var.project_name}-job-bucket"
  })
}

resource "aws_s3_bucket_public_access_block" "job_bucket_block_public" {
  bucket = aws_s3_bucket.job_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}