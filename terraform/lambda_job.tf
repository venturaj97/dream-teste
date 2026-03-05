data "archive_file" "job_lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../lambda"
  output_path = "${path.module}/../lambda.zip"
}

resource "aws_lambda_function" "job_lambda" {
  function_name = "${var.project_name}-daily-s3-writer"
  role          = aws_iam_role.job_lambda_role.arn
  runtime       = "python3.12"
  handler       = "handler.lambda_handler"

  filename         = data.archive_file.job_lambda_zip.output_path
  source_code_hash = data.archive_file.job_lambda_zip.output_base64sha256

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.job_bucket.bucket
    }
  }

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "job_lambda_lg" {
  name              = "/aws/lambda/${aws_lambda_function.job_lambda.function_name}"
  retention_in_days = 7
  tags              = var.tags
}