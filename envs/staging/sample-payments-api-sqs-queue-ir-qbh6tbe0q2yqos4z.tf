module "sample_payments_api_sqs_queue" {
  source = "../../modules/sqs-queue"

  fifo                       = false
  visibility_timeout_seconds = 30
  dead_letter_queue          = true
  kms_encryption             = true

  tags = {
    service          = "sample-payments-api"
    team             = "cloud_platform"
    environment      = "staging"
    data_sensitivity = "internal"
    infra_request_id = "ir-qbh6tbe0q2yqos4z"
    managed_by       = "port"
  }
}