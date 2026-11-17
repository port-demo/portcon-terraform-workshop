module "sample_auth_gateway_rds_postgres" {
  source = "../../modules/rds-postgres"

  instance_class       = "db.t4g.micro"
  allocated_storage_gb = 20
  engine_version       = "16"
  multi_az             = false
  storage_encrypted    = true

  tags = {
    service          = "sample-auth-gateway"
    team             = "data_platform"
    environment      = "test"
    data_sensitivity = "internal"
    infra_request_id = "ir-rlpx7aoqhxkctjhh"
    managed_by       = "port"
  }
}