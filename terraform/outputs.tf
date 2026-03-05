output "region" {
  value = var.aws_region
}

output "job_bucket_name" {
  value = aws_s3_bucket.job_bucket.bucket
}

output "job_lambda_name" {
  value = aws_lambda_function.job_lambda.function_name
}

output "event_rule_name" {
  value = aws_cloudwatch_event_rule.daily_10am.name
}