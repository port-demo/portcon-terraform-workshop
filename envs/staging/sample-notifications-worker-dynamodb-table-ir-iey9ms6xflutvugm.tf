module "sample-notifications-worker_dynamodb_table" {
  source = "../../modules/dynamodb-table"

  table_name             = "sample-notifications-worker-notification-delivery"
  hash_key_name          = "message_id"
  point_in_time_recovery = true
  kms_encryption         = true

  tags = {
    service          = "sample-notifications-worker"
    team             = "cloud-platform"
    environment      = "staging"
    data_sensitivity = "internal"
    infra_request_id = "ir-iey9ms6xflutvugm"
    managed_by       = "port"
  }
}
