variable "region" {
  type        = string
  description = "AWS region where resources will be created"
  default     = "ap-south-1"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.small"
}