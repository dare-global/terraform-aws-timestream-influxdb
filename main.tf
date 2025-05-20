resource "aws_timestreaminfluxdb_db_cluster" "this" {
  count = var.deployment_type == "MULTI_NODE_READ_REPLICAS" ? 1 : 0

  name = var.name

  deployment_type = var.deployment_type

  db_instance_type  = var.db_instance_type
  db_storage_type   = var.db_storage_type
  allocated_storage = var.allocated_storage

  organization = var.organization
  bucket       = var.bucket
  username     = var.username
  password     = var.password

  publicly_accessible    = var.publicly_accessible
  vpc_subnet_ids         = var.vpc_subnet_ids
  vpc_security_group_ids = var.vpc_security_group_ids

  network_type = var.network_type
  port         = var.port

  failover_mode = var.failover_mode

  dynamic "log_delivery_configuration" {
    for_each = var.log_delivery_configuration != null ? [1] : []
    content {
      s3_configuration {
        bucket_name = var.log_delivery_configuration.s3_configuration.bucket_name
        enabled     = var.log_delivery_configuration.s3_configuration.enabled
      }
    }
  }

  tags = var.tags
}

resource "aws_timestreaminfluxdb_db_instance" "this" {
  count = var.deployment_type == "MULTI_NODE_READ_REPLICAS" ? 0 : 1

  name = var.name

  deployment_type = var.deployment_type

  db_instance_type  = var.db_instance_type
  db_storage_type   = var.db_storage_type
  allocated_storage = var.allocated_storage

  organization = var.organization
  bucket       = var.bucket
  username     = var.username
  password     = var.password

  publicly_accessible    = var.publicly_accessible
  vpc_subnet_ids         = var.vpc_subnet_ids
  vpc_security_group_ids = var.vpc_security_group_ids

  dynamic "log_delivery_configuration" {
    for_each = var.log_delivery_configuration != null ? [1] : []
    content {
      s3_configuration {
        bucket_name = var.log_delivery_configuration.s3_configuration.bucket_name
        enabled     = var.log_delivery_configuration.s3_configuration.enabled
      }
    }
  }

  tags = var.tags
}
