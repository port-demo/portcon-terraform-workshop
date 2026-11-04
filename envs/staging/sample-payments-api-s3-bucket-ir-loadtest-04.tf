module "sample_payments_api_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "sample-payments-api-exports-lt04"
  versioning          = true
  block_public_access = true
  encryption          = "aws:kms"

  tags = {
    service          = "sample-payments-api"
    team             = "cloud-platform"
    environment      = "staging"
    data_sensitivity = "internal"
    infra_request_id = "ir-loadtest-04"
    managed_by       = "port"
  }
}
