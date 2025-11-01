variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "Ecs_Serverless_terraform"
}

variable "public_cidr" {
  description = "Cidr block for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_cidr" {
  description = "Cidr block for private suubnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "environment" {
  description = "Working Environment"
  type        = string
  default     = "Testing"
}

variable "target_type" {
  description = "Target_type for alb"
  type        = string
  default     = "ip"
}