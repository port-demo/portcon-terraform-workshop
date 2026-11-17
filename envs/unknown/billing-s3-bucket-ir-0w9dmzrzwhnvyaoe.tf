module "billing_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "billing-invoice-exports"
  versioning          = true
  block_public_access = true
  encryption          = "aws:kms"

  tags = {
    service          = "billing"
    team             = "cloud_platform"
    environment      = "unknown"
    data_sensitivity = "unknown"
    infra_request_id = "ir-0w9dmzrzwhnvyaoe"
    managed_by       = "port"
  }
}