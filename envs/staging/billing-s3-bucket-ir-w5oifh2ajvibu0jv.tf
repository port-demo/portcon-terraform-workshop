module "billing_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "billing-billing-exports"
  versioning          = true
  block_public_access = true
  encryption          = "aws:kms"

  tags = {
    service          = "billing"
    team             = "cloud-platform"
    environment      = "staging"
    data_sensitivity = "internal"
    infra_request_id = "ir-w5oifh2ajvibu0jv"
    managed_by       = "port"
  }
}
