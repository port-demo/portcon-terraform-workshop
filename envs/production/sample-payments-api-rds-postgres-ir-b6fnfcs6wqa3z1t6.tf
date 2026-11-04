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
    data_sensitivity = "internal"
    infra_request_id = "ir-b6fnfcs6wqa3z1t6"
    managed_by       = "port"
  }
}
