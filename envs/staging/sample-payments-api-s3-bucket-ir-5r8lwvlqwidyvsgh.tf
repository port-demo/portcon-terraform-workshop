module "sample_payments_api_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "sample-payments-api-invoices"
  versioning          = true
  block_public_access = true
  encryption          = "aws:kms"

  tags = {
    service          = "sample-payments-api"
    team             = "cloud-platform"
    environment      = "staging"
    data_sensitivity = "internal"
    infra_request_id = "ir-5r8lwvlqwidyvsgh"
    managed_by       = "port"
  }
}
