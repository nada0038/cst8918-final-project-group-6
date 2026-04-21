variable "env" {
  type        = string
  description = "Environment (e.g. test, prod)"
}

variable "location" {
  type        = string
  description = "Location for AKS cluster"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for AKS nodes"
}

variable "node_count" {
  type        = number
  description = "Number of nodes"
  default     = 1
}

variable "min_count" {
  type        = number
  description = "Minimum number of nodes for autoscaling"
  default     = 1
}

variable "max_count" {
  type        = number
  description = "Maximum number of nodes for autoscaling"
  default     = 1
}

variable "vm_size" {
  type        = string
  description = "VM size for nodes"
  default     = "Standard_B2s"
}
