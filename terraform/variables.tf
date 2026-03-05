variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Prefixo para nomear recursos"
  default     = "dream-test"
}

variable "tags" {
  type        = map(string)
  description = "Tags padrão"
  default = {
    Project = "dream-test"
  }
}