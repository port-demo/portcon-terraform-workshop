variable "table_name" {
  description = "DynamoDB table name (required). Must be prefixed with the service name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]+$", var.table_name))
    error_message = "table_name must contain only letters, numbers, underscores, periods, and hyphens."
  }
}

variable "hash_key_name" {
  description = "Name of the partition key attribute."
  type        = string
  default     = "message_id"
}

variable "hash_key_type" {
  description = "Type of the partition key attribute (S, N, or B)."
  type        = string
  default     = "S"

  validation {
    condition     = contains(["S", "N", "B"], var.hash_key_type)
    error_message = "hash_key_type must be S, N, or B."
  }
}

variable "range_key_name" {
  description = "Name of the sort key attribute (optional)."
  type        = string
  default     = null
}

variable "range_key_type" {
  description = "Type of the sort key attribute (S, N, or B)."
  type        = string
  default     = "S"

  validation {
    condition     = contains(["S", "N", "B"], var.range_key_type)
    error_message = "range_key_type must be S, N, or B."
  }
}

variable "billing_mode" {
  description = "DynamoDB billing mode (PROVISIONED or PAY_PER_REQUEST)."
  type        = string
  default     = "PAY_PER_REQUEST"

  validation {
    condition     = contains(["PROVISIONED", "PAY_PER_REQUEST"], var.billing_mode)
    error_message = "billing_mode must be PROVISIONED or PAY_PER_REQUEST."
  }
}

variable "point_in_time_recovery" {
  description = "Enable point-in-time recovery."
  type        = bool
  default     = true
}

variable "kms_encryption" {
  description = "Encrypt the table at rest with KMS."
  type        = bool
  default     = true
}

variable "ttl_attribute_name" {
  description = "Name of the TTL attribute (optional). When set, TTL is enabled on the table."
  type        = string
  default     = null
}

variable "tags" {
  description = "Resource tags including service, team, environment, data_sensitivity, infra_request_id, and managed_by."
  type        = map(string)
}
