module "sample_inventory_service_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "sample-inventory-service-inventory-reports"
  versioning          = true
  block_public_access = true
  encryption          = "aws:kms"

  tags = {
    service          = "sample-inventory-service"
    team             = "cloud_platform"
    environment      = "test"
    data_sensitivity = "public"
    infra_request_id = "ir-dmyqgsryxwossb9j"
    managed_by       = "port"
  }
}