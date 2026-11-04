module "billing_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "billing-invoices"
  versioning          = true
  block_public_access = false
  encryption          = "aws:kms"

  tags = {
    service          = "billing"
    team             = "cloud-platform"
    environment      = "staging"
    data_sensitivity = "confidential"
    infra_request_id = "ir-uymheghyyftuivgr"
    managed_by       = "port"
  }
}
