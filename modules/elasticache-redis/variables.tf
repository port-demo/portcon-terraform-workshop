variable "node_type" {
  description = "ElastiCache node type."
  type        = string
  default     = "cache.t4g.micro"
}

variable "num_cache_nodes" {
  description = "Number of cache nodes."
  type        = number
  default     = 1
}

variable "transit_encryption" {
  description = "Enable in-transit (TLS) encryption."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Resource tags including service, team, environment, data_sensitivity, infra_request_id, and managed_by."
  type        = map(string)
}
