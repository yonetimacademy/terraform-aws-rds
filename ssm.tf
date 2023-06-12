resource "aws_ssm_parameter" "main_db_host" {
  name        = "/${var.tenant}/${var.name}/${var.environment}/rds/${var.database_name}/host"
  description = "Managed by yonetimacademy"
  type        = "SecureString"
  value       = (var.aurora_cluster == true) ? aws_rds_cluster.main[0].endpoint : aws_db_instance.main[0].address

  tags = {
    Name        = "${var.tenant}-${var.name}-${var.environment}-rds-${var.database_name}-host"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "yonetimacademy"
    Terraform   = "yes"
  }
}

resource "aws_ssm_parameter" "main_db_port" {
  name        = "/${var.tenant}/${var.name}/${var.environment}/rds/${var.database_name}/port"
  description = "Managed by yonetimacademy"
  type        = "SecureString"
  value       = var.port

  tags = {
    Name        = "${var.tenant}-${var.name}-${var.environment}-rds-${var.database_name}-port"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "yonetimacademy"
    Terraform   = "yes"
  }
}

resource "aws_ssm_parameter" "main_db_name" {
  name        = "/${var.tenant}/${var.name}/${var.environment}/rds/${var.database_name}/name"
  description = "Managed by yonetimacademy"
  type        = "SecureString"
  value       = (var.aurora_cluster == true) ? aws_rds_cluster.main[0].database_name : aws_db_instance.main[0].db_name

  tags = {
    Name        = "${var.tenant}-${var.name}-${var.environment}-rds-${var.database_name}-name"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "yonetimacademy"
    Terraform   = "yes"
  }
}

resource "aws_ssm_parameter" "main_db_user" {
  name        = "/${var.tenant}/${var.name}/${var.environment}/rds/${var.database_name}/user"
  description = "Managed by yonetimacademy"
  type        = "SecureString"
  value       = (var.aurora_cluster == true) ? aws_rds_cluster.main[0].master_username : aws_db_instance.main[0].username

  tags = {
    Name        = "${var.tenant}-${var.name}-${var.environment}-rds-${var.database_name}-user"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "yonetimacademy"
    Terraform   = "yes"
  }
}

resource "aws_ssm_parameter" "main_db_pass" {
  name        = "/${var.tenant}/${var.name}/${var.environment}/rds/${var.database_name}/pass"
  description = "Managed by yonetimacademy"
  type        = "SecureString"
  value       = random_password.dbpass.result

  tags = {
    Name        = "${var.tenant}-${var.name}-${var.environment}-rds-${var.database_name}-pass"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "yonetimacademy"
    Terraform   = "yes"
  }
}