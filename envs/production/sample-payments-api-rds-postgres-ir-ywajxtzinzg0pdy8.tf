module "sample_payments_api_rds_postgres" {
  source = "../../modules/rds-postgres"

  instance_class       = "db.t4g.micro"
  allocated_storage_gb = 20
  engine_version       = "16"
  multi_az             = true
  storage_encrypted    = true

  tags = {
    service          = "sample-payments-api"
    team             = "data-platform"
    environment      = "production"
    data_sensitivity = "confidential"
    infra_request_id = "ir-ywajxtzinzg0pdy8"
    managed_by       = "port"
  }
}
