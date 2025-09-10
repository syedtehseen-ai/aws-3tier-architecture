variable "tags" {
  description = "Global tags for all resources"
  type        = map(string)
  default     = {}
}

variable "project_name" {
  type = string
}


variable "static_indexpage" {
  type = string
}

