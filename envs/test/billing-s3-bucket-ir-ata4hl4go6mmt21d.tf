module "billing_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "billing-bucket"
  versioning          = true
  block_public_access = true
  encryption          = "aws:kms"

  tags = {
    service          = "billing"
    team             = "cloud_platform"
    environment      = "test"
    data_sensitivity = "internal"
    infra_request_id = "ir-ata4hl4go6mmt21d"
    managed_by       = "port"
  }
}