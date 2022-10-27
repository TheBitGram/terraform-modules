resource "aws_appautoscaling_target" "dynamodb_index_read_target" {
  min_capacity       = var.capacity["min_read"]
  max_capacity       = var.capacity["max_read"]
  resource_id        = "table/${var.table_name}/index/${var.index_name}"
  scalable_dimension = "dynamodb:index:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_read_policy" {
  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.dynamodb_index_read_target.resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_index_read_target.resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_index_read_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_index_read_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    target_value = var.read_target_value
  }
}

resource "aws_appautoscaling_target" "dynamodb_index_write_target" {
  min_capacity       = var.capacity["min_write"]
  max_capacity       = var.capacity["max_write"]
  resource_id        = "table/${var.table_name}/index/${var.index_name}"
  scalable_dimension = "dynamodb:index:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_write_policy" {
  name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.dynamodb_index_write_target.resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_write_target.resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_write_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_write_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    target_value = var.write_target_value
  }
}