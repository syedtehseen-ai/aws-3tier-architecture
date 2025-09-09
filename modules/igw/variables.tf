variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

variable "region" {
  description = "Name of the region"
  type        = string
}
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "tags" {
  description = "Global tags for all resources"
  type        = map(string)
  default     = {}
}