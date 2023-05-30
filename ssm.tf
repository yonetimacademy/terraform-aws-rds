resource "random_string" "dbname" {
  length  = 10
  numeric = false
  special = false
}

resource "random_string" "dbuser" {
  length  = 12
  numeric = false
  special = false
}

resource "random_password" "dbpass" {
  length           = 16
  special          = true
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 2
  min_special      = 2
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_ssm_parameter" "main_db_host" {
  name        = "/${var.tenant}/${var.name}/${var.environment}/database/host"
  description = "Managed by Magicorn"
  type        = "SecureString"
  value       = (var.aurora_cluster == true) ? aws_rds_cluster.main[0].endpoint : aws_db_instance.main[0].address

  tags = {
    Name        = "${var.tenant}-${var.name}-${var.environment}-database-host"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

resource "aws_ssm_parameter" "main_db_port" {
  name        = "/${var.tenant}/${var.name}/${var.environment}/database/port"
  description = "Managed by Magicorn"
  type        = "SecureString"
  value       = var.port

  tags = {
    Name        = "${var.tenant}-${var.name}-${var.environment}-database-port"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

resource "aws_ssm_parameter" "main_db_name" {
  name        = "/${var.tenant}/${var.name}/${var.environment}/database/name"
  description = "Managed by Magicorn"
  type        = "SecureString"
  value       = (var.aurora_cluster == true) ? aws_rds_cluster.main[0].database_name : aws_db_instance.main[0].db_name

  tags = {
    Name        = "${var.tenant}-${var.name}-${var.environment}-database-name"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

resource "aws_ssm_parameter" "main_db_user" {
  name        = "/${var.tenant}/${var.name}/${var.environment}/database/user"
  description = "Managed by Magicorn"
  type        = "SecureString"
  value       = (var.aurora_cluster == true) ? aws_rds_cluster.main[0].master_username : aws_db_instance.main[0].username

  tags = {
    Name        = "${var.tenant}-${var.name}-${var.environment}-database-user"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

resource "aws_ssm_parameter" "main_db_pass" {
  name        = "/${var.tenant}/${var.name}/${var.environment}/database/pass"
  description = "Managed by Magicorn"
  type        = "SecureString"
  value       = random_password.dbpass.result

  tags = {
    Name        = "${var.tenant}-${var.name}-${var.environment}-database-pass"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}