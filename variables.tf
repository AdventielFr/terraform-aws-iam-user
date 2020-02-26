variable "aws_region" {
  type        = string
  description = "Aws region"
}

variable "name" {
  type        = string
  description = "User name"
  default     = ""
}

variable "email" {
  description = " Email of user"
  type        = string
}

variable "tags" {
  type    = map
  default = {}
}

variable "cli_access" {
  description = "Allow access AWS Cli if the value is true"
  type        = bool
  default     = true
}

variable "console_access" {
  description = "Allow access Web AWS console if the value is true"
  type        = bool
  default     = true
}

variable "public_key" {
  description = "Allow access Web AWS console if the value is true"
  type        = string
}

variable "password_reset_required" {
  type    = bool
  default = true
  description = "Whether the user should be forced to reset the generated password on resource creation."
}

variable "policies" {
  description = "List of ARN of policies to set on the user"
  type        = list(string)
  default     = []
}