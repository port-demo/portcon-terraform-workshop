module "billing_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "billing-invoice-pdfs"
  versioning          = true
  block_public_access = true
  encryption          = "aws:kms"

  tags = {
    service          = "billing"
    team             = "cloud_platform"
    environment      = "staging"
    data_sensitivity = "confidential"
    infra_request_id = "ir-dl7tg1zqcvt0ufxi"
    managed_by       = "port"
  }
}