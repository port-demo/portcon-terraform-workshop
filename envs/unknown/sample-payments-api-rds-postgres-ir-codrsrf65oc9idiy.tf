module "sample_payments_api_rds_postgres" {
  source = "../../modules/rds-postgres"

  instance_class       = "db.t4g.micro"
  allocated_storage_gb = 20
  engine_version       = "16"
  multi_az             = false
  storage_encrypted    = true

  tags = {
    service          = "sample-payments-api"
    team             = "data_platform"
    environment      = "unknown"
    data_sensitivity = "unknown"
    infra_request_id = "ir-codrsrf65oc9idiy"
    managed_by       = "port"
  }
}