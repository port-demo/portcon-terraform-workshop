variable "instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t4g.micro"
}

variable "allocated_storage_gb" {
  description = "Allocated storage in GB."
  type        = number
  default     = 20
}

variable "engine_version" {
  description = "PostgreSQL major engine version."
  type        = string
  default     = "16"
}

variable "multi_az" {
  description = "Deploy a standby in a second availability zone."
  type        = bool
  default     = false
}

variable "storage_encrypted" {
  description = "Encrypt storage at rest with KMS."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Resource tags including service, team, environment, data_sensitivity, infra_request_id, and managed_by."
  type        = map(string)
}
