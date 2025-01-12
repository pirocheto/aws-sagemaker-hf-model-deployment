

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "model_author_name" {
  description = "Author name of the model"
}

variable "model_name" {
  description = "Name of the model"
}

variable "model_src" {
  description = "Path to the model.tar.gz file"
}

variable "python_version" {
  description = "Python version"
}

variable "ubuntu_version" {
  description = "Ubuntu version"
}

variable "transformers_version" {
  description = "Transformers version"
}

variable "pytorch_version" {
  description = "PyTorch version"
}


variable "model_bucket_name" {
  description = "Name of the S3 bucket to store the model"
}

variable "model_bucket_key" {
  description = "Key of the S3 bucket to store the model"
}

variable "instance_type" {
  description = "Instance type for the endpoint"
  default     = "ml.m5.large"
}

variable "memory_size_in_mb" {
  description = "Memory size in MB for the endpoint"
  default     = 2048
}

variable "max_concurrency" {
  description = "Maximum concurrency for the endpoint"
  default     = 1
}
