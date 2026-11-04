module "sample_orders_api_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "sample-orders-api-exports-lt02"
  versioning          = true
  block_public_access = true
  encryption          = "aws:kms"

  tags = {
    service          = "sample-orders-api"
    team             = "cloud-platform"
    environment      = "staging"
    data_sensitivity = "internal"
    infra_request_id = "ir-loadtest-02"
    managed_by       = "port"
  }
}
