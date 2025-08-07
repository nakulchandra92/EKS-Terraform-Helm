# terraform/variables.tf
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "minimal-eks"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "demo"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "enable_cluster_autoscaler" {
  description = "Enable cluster autoscaler IAM role"
  type        = bool
  default     = true
}

