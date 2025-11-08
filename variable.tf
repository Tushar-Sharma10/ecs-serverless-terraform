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
    condition     = contains(["generalPurpose", "maxIO"], var.performance_mode)
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

# ECS CLUSTER
variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
  default     = "ecs_cluster"
}

variable "setting_name" {
  description = "Name of the settings to manage"
  type        = string
  default     = "containerInsights"

  validation {
    condition     = var.setting_name == "containerInsights"
    error_message = "Settings name can only be 'containerInsights'"
  }
}

variable "setting_value" {
  description = "value to assign to settings"
  type        = string
  default     = "enabled"

  validation {
    condition     = contains(["enhanced", "enabled", "disabled"], var.setting_value)
    error_message = "Settings value should be ony from these(enhanced, enabled,disabled)"
  }
}

variable "region" {
  description = "Region for container"
  type        = string
  default     = "us-east-1"
}

variable "requires_compatibilities" {
  description = "Launch type for ECS task definition"
  type        = string
  default     = "FARGATE"

  validation {
    condition     = contains(["FARGATE", "EC2"], var.requires_compatibilities)
    error_message = "Required compatabilites must be either 'FARGATE' or 'EC2'."
  }
}

variable "skip_destroy" {
  description = "Whether to retain the old revision when the resource is destroyed"
  type        = bool
  default     = false
}

variable "track_latest" {
  description = "To track the latest revision or update"
  type        = bool
  default     = false
}

variable "volume_name" {
  description = "Name of the volume"
  type        = string
  default     = "EFSvolume"
}

variable "cpu" {
  description = "CPU value"
  type        = string
  default     = "512"
}

variable "memory" {
  description = "Memory value"
  type        = string
  default     = "2048"
}

variable "launch_type" {
  description = "Launch type"
  type = string
  default = "FARGATE"
}

variable "platform_version" {
  description = "Version of platform"
  type = string
  default = "LATEST"
}

variable "desired_count" {
  description = "Number of instances of the task definition to place and keep running"
  type = number
  default = 2
}

variable "max_percent" {
  description = "Maximum number of tasks that can run during the update"
  type = number
  default = 200
}

variable "min_percent" {
  description = "Minimum number of tasks that must remain running and healthy during update"
  type = number
  default = 50
}

variable "health_check_grace_period_seconds" {
  description = "How long should ecs wait before checking the health of new task after it starts"
  type = number
  default = 300
}