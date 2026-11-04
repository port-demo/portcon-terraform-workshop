module "billing_sqs_queue" {
  source = "../../modules/sqs-queue"

  fifo                       = false
  visibility_timeout_seconds = 60
  dead_letter_queue          = true
  kms_encryption             = true

  tags = {
    service          = "billing"
    team             = "cloud-platform"
    environment      = "staging"
    data_sensitivity = "internal"
    infra_request_id = "ir-loadtest-03"
    managed_by       = "port"
  }
}
