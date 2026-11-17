module "billing_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "billing-invoice-exports"
  versioning          = true
  block_public_access = true
  encryption          = "aws:kms"

  tags = {
    service          = "billing"
    team             = "cloud_platform"
    environment      = "staging"
    data_sensitivity = "internal"
    infra_request_id = "ir-owhxz3f4wnzi08wk"
    managed_by       = "port"
  }
}