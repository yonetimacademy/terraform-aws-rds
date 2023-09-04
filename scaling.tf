resource "aws_appautoscaling_target" "main" {
  count              = (var.replica_autoscaling == true) ? 1 : 0
  service_namespace  = "rds"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  resource_id        = "cluster:${aws_rds_cluster.main[0].id}"
  min_capacity       = var.replica_min
  max_capacity       = var.replica_max

  tags = {
    Name        = "${var.tenant}-${var.name}-${var.database_name}-ast-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "yonetimacademy"
    Terraform   = "yes"
  }
}

resource "aws_appautoscaling_policy" "main" {
  count              = (var.replica_autoscaling == true) ? 1 : 0
  name               = "${var.tenant}-${var.name}-${var.database_name}-asp-${var.environment}"
  service_namespace  = aws_appautoscaling_target.main[0].service_namespace
  scalable_dimension = aws_appautoscaling_target.main[0].scalable_dimension
  resource_id        = aws_appautoscaling_target.main[0].resource_id
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "RDSReaderAverageCPUUtilization"
    }

    target_value       = var.target_value
    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown
  }
}