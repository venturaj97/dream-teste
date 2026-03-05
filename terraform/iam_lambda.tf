data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "job_lambda_role" {
  name_prefix        = "${var.project_name}-job-lambda-role-"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

  tags = var.tags
}

# Permissões: logs + putObject no bucket
data "aws_iam_policy_document" "job_lambda_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }

  statement {
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.job_bucket.arn}/*"]
  }
}

resource "aws_iam_role_policy" "job_lambda_role_policy" {
  name_prefix = "${var.project_name}-job-lambda-policy-"
  role        = aws_iam_role.job_lambda_role.id
  policy      = data.aws_iam_policy_document.job_lambda_policy.json
}