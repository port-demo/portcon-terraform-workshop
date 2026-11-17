module "billing_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "billing-invoice-pdfs"
  versioning          = true
  block_public_access = false
  encryption          = "aws:kms"

  tags = {
    service          = "billing"
    team             = "cloud_platform"
    environment      = "staging"
    data_sensitivity = "confidential"
    infra_request_id = "ir-exc7xx3w01bv6x2w"
    managed_by       = "port"
  }
}