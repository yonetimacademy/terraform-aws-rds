resource "aws_db_subnet_group" "main" {
  name        = "${var.tenant}-${var.name}-${var.database_name}-snetg-${var.environment}"
  description = "Managed by yonetimacademy"
  subnet_ids  = var.subnet_ids

  tags = {
    Name        = "${var.tenant}-${var.name}-${var.database_name}-snetg-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "yonetimacademy"
    Terraform   = "yes"
  }
}