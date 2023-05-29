resource "aws_db_parameter_group" "main" {
  name        = "${var.tenant}-${var.name}-rds-pg-${var.environment}"
  description = "Managed by Cloud&Cloud"
  family      = (var.aurora_cluster == true) ? var.aurora_parameter_group : var.parameter_group

  dynamic "parameter" {
    for_each = (var.aurora_cluster == false) ? [true] : []
    content {
      name  = "rds.force_ssl"
      value = "1"
    }
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-rds-pg-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Terraform   = "yes"
  }
}