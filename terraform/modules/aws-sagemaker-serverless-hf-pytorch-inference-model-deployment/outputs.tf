
output "sagemaker_endpoint_name" {
  value = aws_sagemaker_endpoint.model_endpoint.name
}

output "sagemaker_endpoint_arn" {
  value = aws_sagemaker_endpoint.model_endpoint.arn
}

output "sagemaker_endpoint_config_name" {
  value = aws_sagemaker_endpoint_configuration.model_endpoint_configuration.name
}

output "sagemaker_endpoint_config_arn" {
  value = aws_sagemaker_endpoint_configuration.model_endpoint_configuration.arn
}

output "sagemaker_model_name" {
  value = aws_sagemaker_model.model.name
}

output "sagemaker_model_arn" {
  value = aws_sagemaker_model.model.arn
}

output "sagemaker_model_image" {
  value = aws_sagemaker_model.model.primary_container.0.image
}

output "sagemaker_model_data_url" {
  value = aws_sagemaker_model.model.primary_container.0.model_data_url
}

output "sagemaker_model_execution_role_arn" {
  value = aws_sagemaker_model.model.execution_role_arn
}
