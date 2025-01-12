data "aws_caller_identity" "current" {}

locals {
  account_id     = data.aws_caller_identity.current.account_id
  ecr_image_name = "763104351884.dkr.ecr.${var.aws_region}.amazonaws.com/huggingface-pytorch-inference"
  ecr_image_tag  = "${var.pytorch_version}-transformers${var.transformers_version}-cpu-${var.python_version}-ubuntu${var.ubuntu_version}"
}


resource "aws_iam_role" "model_execution_role" {
  name = "sagemaker-${var.model_name}-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_policy" "s3_policy" {
  name = "sagemaker-${var.model_name}-s3-policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
          "s3:ListBucket",
        ],
        "Resource" : "arn:aws:s3:::${var.model_bucket_name}/*"
      }
    ]
  })
}

resource "aws_iam_policy" "ecr_policy" {
  name = "sagemaker-${var.model_name}-ecr-policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:GetLifecyclePolicy",
          "ecr:GetLifecyclePolicyPreview",
          "ecr:ListTagsForResource",
          "ecr:DescribeImageScanFindings",
        ],
        "Resource" : "arn:aws:ecr:${var.aws_region}:*:repository/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
  policy_arn = aws_iam_policy.s3_policy.arn
  role       = aws_iam_role.model_execution_role.name
}

resource "aws_iam_role_policy_attachment" "ecr_policy_attachment" {
  policy_arn = aws_iam_policy.ecr_policy.arn
  role       = aws_iam_role.model_execution_role.name
}


resource "aws_sagemaker_model" "model" {
  name               = var.model_name
  execution_role_arn = aws_iam_role.model_execution_role.arn
  primary_container {
    image          = "${local.ecr_image_name}:${local.ecr_image_tag}"
    model_data_url = "s3://${var.model_bucket_name}/${var.model_bucket_key}"
  }
}

resource "aws_sagemaker_endpoint_configuration" "model_endpoint_configuration" {
  name = "sagemaker-${var.model_name}-endpoint-config"
  production_variants {
    initial_variant_weight = 1
    model_name             = aws_sagemaker_model.model.name
    variant_name           = "Version1"

    serverless_config {
      memory_size_in_mb = var.memory_size_in_mb
      max_concurrency   = var.max_concurrency
    }
  }
}

resource "aws_sagemaker_endpoint" "model_endpoint" {
  endpoint_config_name = aws_sagemaker_endpoint_configuration.model_endpoint_configuration.name
  name                 = "${var.model_name}-endpoint"
}

