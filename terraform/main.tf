locals {
  env = terraform.workspace
}

module "model" {
  source               = "./modules/aws-sagemaker-hf-pytorch-inference-model-deployment"
  aws_region           = "us-east-1"
  model_name           = "${local.env}-multilingual-sentiment-analysis"
  python_version       = "py310"
  ubuntu_version       = "22.04"
  transformers_version = "4.37.0"
  pytorch_version      = "2.1.0"
  model_bucket_name    = "sagemaker-us-east-1-639269844451"
  model_bucket_key     = "${local.env}/tabularisai/multilingual-sentiment-analysis/model.tar.gz"
  instance_type        = "ml.m5.large"
  memory_size_in_mb    = 2048
  max_concurrency      = 1
}
