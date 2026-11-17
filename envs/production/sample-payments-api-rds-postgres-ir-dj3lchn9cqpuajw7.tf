module "sample_payments_api_rds_postgres" {
  source = "../../modules/rds-postgres"

  instance_class       = "db.t4g.micro"
  allocated_storage_gb = 2048
  engine_version       = "16"
  multi_az             = true
  storage_encrypted    = true

  tags = {
    service          = "sample-payments-api"
    team             = "data_platform"
    environment      = "production"
    data_sensitivity = "internal"
    infra_request_id = "ir-dj3lchn9cqpuajw7"
    managed_by       = "port"
  }
}