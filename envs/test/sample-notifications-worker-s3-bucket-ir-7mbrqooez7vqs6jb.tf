module "sample_notifications_worker_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "sample-notifications-worker-invoice-pdfs"
  versioning          = true
  block_public_access = false
  encryption          = "aws:kms"

  tags = {
    service          = "sample-notifications-worker"
    team             = "cloud_platform"
    environment      = "test"
    data_sensitivity = "confidential"
    infra_request_id = "ir-7mbrqooez7vqs6jb"
    managed_by       = "port"
  }
}