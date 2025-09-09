variable "project_name" {
  type = string
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "pubsubnets" {
  description = "Map of subnets for all environments"
  type = map(object({
    cidr  = string
    pubaz = string
  }))
}

variable "pvtsubnets" {
  description = "Map of subnets for all environments"
  type = map(object({
    cidr  = string
    pvtaz = string
  }))
}

variable "private_subnet_natgw_map" {
  description = "Map private subnet key to NAT Gateway key"
  type        = map(string)
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

# variable "igw_id" {
#   description = "The ID of the IGW"
#   type        = string
# }

variable "env_name" {
  description = "Environment name (dev/qa/prod)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for ASG"
  type        = string
}

variable "tags" {
  description = "Global tags for all resources"
  type        = map(string)
  default     = {}
}

# variable "aws_access_key" {
#   type        = string
#   description = "AWS access key"
# }

# variable "aws_secret_key" {
#   type        = string
#   description = "AWS secret key"
# }

variable "vpctag" {
  description = "Name tag for the VPC"
  type        = string
}
