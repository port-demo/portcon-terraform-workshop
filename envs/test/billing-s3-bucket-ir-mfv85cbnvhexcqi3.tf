module "billing_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "billing-invoice-exports"
  versioning          = true
  block_public_access = true
  encryption          = "aws:kms"

  tags = {
    service          = "billing"
    team             = "cloud_platform"
    environment      = "test"
    data_sensitivity = "confidential"
    infra_request_id = "ir-mfv85cbnvhexcqi3"
    managed_by       = "port"
  }
}