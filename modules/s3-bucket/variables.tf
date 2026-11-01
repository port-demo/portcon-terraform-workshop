variable "bucket_name" {
  description = "Bucket name (required). Must be prefixed with the service name."
  type        = string
}

variable "versioning" {
  description = "Enable object versioning."
  type        = bool
  default     = true
}

variable "block_public_access" {
  description = "Block all public access to the bucket."
  type        = bool
  default     = true
}

variable "encryption" {
  description = "Server-side encryption algorithm (aws:kms or AES256)."
  type        = string
  default     = "aws:kms"
}

variable "tags" {
  description = "Resource tags including service, team, environment, data_sensitivity, infra_request_id, and managed_by."
  type        = map(string)
}
