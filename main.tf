# resource "aws_timestreaminfluxdb_db_cluster" "this" {
#   count = var.deployment_type == "MULTI_NODE_READ_REPLICAS" ? 1 : 0

#   name = var.name

#   deployment_type = var.deployment_type

#   db_instance_type  = var.db_instance_type
#   db_storage_type   = var.db_storage_type
#   allocated_storage = var.allocated_storage

#   organization = var.organization
#   bucket       = var.bucket
#   username     = var.username
#   password     = var.password

#   publicly_accessible    = var.publicly_accessible
#   vpc_subnet_ids         = var.vpc_subnet_ids
#   vpc_security_group_ids = concat([local.internal_security_group], var.vpc_security_group_ids)

#   network_type = var.network_type
#   port         = var.port

#   failover_mode = var.failover_mode

#   dynamic "log_delivery_configuration" {
#     for_each = var.log_delivery_configuration != null ? [1] : []
#     content {
#       s3_configuration {
#         bucket_name = var.log_delivery_configuration.s3_configuration.bucket_name
#         enabled     = var.log_delivery_configuration.s3_configuration.enabled
#       }
#     }
#   }

#   tags = var.tags
# }

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
  vpc_security_group_ids = concat([local.internal_security_group], var.vpc_security_group_ids)

  network_type = var.network_type
  port         = var.port

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

#####
# Security group resources
#####
locals {
  internal_security_group = try(aws_security_group.this[0].id, "")
}

resource "aws_security_group" "this" {
  count = length(var.ingress_cidr_blocks) == 0 && length(var.ingress_ipv6_cidr_blocks) == 0 && length(var.ingress_prefix_list_ids) == 0 ? 0 : 1

  name_prefix = "${var.name}-sg-"
  description = "Timestream InfluxDB: ${var.name}"

  vpc_id = data.aws_subnet.this.vpc_id

  revoke_rules_on_delete = true

  tags = merge(
    {
      "Name" = "${var.name}-sg"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "this_ingress_cidr_blocks" {
  count = length(var.ingress_cidr_blocks) != 0 ? 1 : 0

  description = "Allow Ingress ipv4 CIDR blocks."

  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = var.ingress_cidr_blocks
  security_group_id = aws_security_group.this[0].id
}

resource "aws_security_group_rule" "this_ingress_ipv6_cidr_blocks" {
  count = length(var.ingress_ipv6_cidr_blocks) != 0 ? 1 : 0

  description = "Allow Ingress ipv6 CIDR blocks."

  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  ipv6_cidr_blocks  = var.ingress_ipv6_cidr_blocks
  security_group_id = aws_security_group.this[0].id
}

resource "aws_security_group_rule" "this_ingress_prefix_list_ids" {
  count = length(var.ingress_prefix_list_ids) != 0 ? 1 : 0

  description = "Allow Ingress prefix list ids."

  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  prefix_list_ids   = var.ingress_prefix_list_ids
  security_group_id = aws_security_group.this[0].id
}
