resource "aws_db_subnet_group" "main" {
  name        = "${var.tenant}-${var.name}-rds-snetg-${var.environment}"
  description = "Managed by Cloud&Cloud"
  subnet_ids  = var.db_subnet_ids

  tags = {
    Name        = "${var.tenant}-${var.name}-rds-snetg-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Terraform   = "yes"
  }
}