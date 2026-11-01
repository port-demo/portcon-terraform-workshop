variable "fifo" {
  description = "Create a FIFO queue."
  type        = bool
  default     = false
}

variable "visibility_timeout_seconds" {
  description = "Visibility timeout in seconds."
  type        = number
  default     = 30
}

variable "dead_letter_queue" {
  description = "Create and attach a dead-letter queue."
  type        = bool
  default     = true
}

variable "kms_encryption" {
  description = "Encrypt messages with KMS."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Resource tags including service, team, environment, data_sensitivity, infra_request_id, and managed_by."
  type        = map(string)
}
