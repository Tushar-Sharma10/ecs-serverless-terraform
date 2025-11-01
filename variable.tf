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

variable "encrypted" {
  description = "If true the disk will be encrypted"
  type        = bool
  default     = true
}

variable "performance_mode" {
  description = "File system performace mode for EFS"
  type        = string
  default     = "generalPurpose"
  validation {
    condition     = var.performance_mode == "generalPurpose" || var.performance_mode == "maxIO"
    error_message = "Performance must be either 'generalPurpose' or 'maxIO'"
  }
}

variable "creation_token" {
  description = "A unique name"
  type        = string
  default     = "my-efs"
}

variable "transition_to_ia" {
  description = "Indicates how long it takes to transition files to the IA storage class"
  type        = string
  default     = "AFTER_30_DAYS"
}