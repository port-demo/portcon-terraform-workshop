module "sample_payments_api_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "sample-payments-api-reconciliation-reports"
  versioning          = true
  block_public_access = false
  encryption          = "aws:kms"

  tags = {
    service          = "sample-payments-api"
    team             = "cloud-platform"
    environment      = "staging"
    data_sensitivity = "confidential"
    infra_request_id = "ir-pcajyx3fnp1sshw9"
    managed_by       = "port"
  }
}
