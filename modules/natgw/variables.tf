variable "public_subnets_ids" {
  description = "Map of subnets IDs"
  type        = map(string)
}
variable "tags" {
  description = "Global tags for all resources"
  type        = map(string)
  default     = {}
}
variable "igw_id" {
  description = "The ID of the IGW"
  type        = string
}