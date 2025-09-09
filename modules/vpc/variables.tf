variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "vpctag" {
  description = "Name tag for the VPC"
  type        = string
}

variable "tags" {
  description = "Global tags for all resources"
  type        = map(string)
  default     = {}
}