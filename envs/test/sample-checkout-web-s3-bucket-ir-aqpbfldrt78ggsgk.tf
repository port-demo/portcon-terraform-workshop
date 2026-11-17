module "sample_checkout_web_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "sample-checkout-web-invoice-exports"
  versioning          = true
  block_public_access = true
  encryption          = "aws:kms"

  tags = {
    service          = "sample-checkout-web"
    team             = "cloud_platform"
    environment      = "test"
    data_sensitivity = "public"
    infra_request_id = "ir-aqpbfldrt78ggsgk"
    managed_by       = "port"
  }
}