variable "pubsubnets" {
  description = "Map of subnets for all environments"
  type        = map(object({ 
    cidr = string
    pubaz = string
  }))
}

variable "pvtsubnets" {
  description = "Map of subnets for all environments"
  type        = map(object({ 
    cidr = string
    pvtaz = string
  }))
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