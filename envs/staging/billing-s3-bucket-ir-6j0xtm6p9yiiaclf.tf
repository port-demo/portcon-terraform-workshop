module "billing_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "billing-invoice-pdfs"
  versioning          = true
  block_public_access = true
  encryption          = "aws:kms"

  tags = {
    service          = "billing"
    team             = "cloud-platform"
    environment      = "staging"
    data_sensitivity = "internal"
    infra_request_id = "ir-6j0xtm6p9yiiaclf"
    managed_by       = "port"
  }
}
