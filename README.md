# terraform-aws-rds

Cloud&Cloud made Terraform Module for AWS Provider
--
```
module "rds" {
  source         = "yonetimacademy/rds/aws"
  version        = "0.0.1"
  tenant         = var.tenant
  name           = var.name
  environment    = var.environment
  vpc_id         = var.vpc_id
  cidr_block     = var.cidr_block
  subnet_ids     = var.subnet_ids
  encryption     = true # 1
  kms_key_id     = var.rds_key_id
  aurora_cluster = false

  # RDS Configuration (Generic)
  database_name               = "master"
  multi_az                    = false
  port                        = 5432
  instance_type               = "db.t4g.small"
  engine_version              = "14.7"
  maintenance_window          = "sun:02:00-sun:03:00"
  backup_window               = "01:00-02:00"
  backup_retention_period     = 7
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = false
  deletion_protection         = true
  apply_immediately           = true

  # RDS Configuration (If == Aurora)
  replica_count          = 2
  aurora_parameter_group = "aurora-postgresql14"

  # RDS Configuration (If =! Aurora)
  allocated_storage     = 20
  max_allocated_storage = 1000
  storage_type          = "gp3"
  storage_throughput    = null
  parameter_group       = "postgres14"
}
```

## Notes
1) Works better with yonetimacademy-aws-kms module.
2) Supports RDS and Aurora PostgreSQLs only (yet)..
