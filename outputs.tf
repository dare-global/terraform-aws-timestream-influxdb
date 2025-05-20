# output "cluster_id" {
#   description = "ID of the Timestream for InfluxDB cluster"
#   value       = try(aws_timestreaminfluxdb_db_cluster.this[0].id, "")
# }

# output "cluster_endpoint" {
#   description = "Endpoint for the InfluxDB cluster"
#   value       = try(aws_timestreaminfluxdb_db_cluster.this[0].endpoint, "")
# }

# output "cluster_reader_endpoint" {
#   description = "The endpoint used to connect to the Timestream for InfluxDB cluster for read-only operations."
#   value       = try(aws_timestreaminfluxdb_db_cluster.this[0].reader_endpoint, "")
# }

# output "cluster_arn" {
#   description = "ARN of the InfluxDB cluster"
#   value       = try(aws_timestreaminfluxdb_db_cluster.this[0].arn, "")
# }

# output "cluster_influx_auth_parameters_secret_arn" {
#   description = "ARN of the AWS Secrets Manager secret containing the initial InfluxDB authorization parameters. The secret value is a JSON formatted key-value pair holding InfluxDB authorization values: organization, bucket, username, and password."
#   value       = try(aws_timestreaminfluxdb_db_cluster.this[0].influx_auth_parameters_secret_arn, "")
# }

output "instance_id" {
  description = "ID of the Timestream for InfluxDB instance"
  value       = try(aws_timestreaminfluxdb_db_instance.this[0].id, "")
}

output "instance_endpoint" {
  description = "Endpoint for the InfluxDB instance"
  value       = try(aws_timestreaminfluxdb_db_instance.this[0].endpoint, "")
}

output "instance_arn" {
  description = "ARN of the InfluxDB instance"
  value       = try(aws_timestreaminfluxdb_db_instance.this[0].arn, "")
}

output "instance_influx_auth_parameters_secret_arn" {
  description = "ARN of the AWS Secrets Manager secret containing the initial InfluxDB authorization parameters. The secret value is a JSON formatted key-value pair holding InfluxDB authorization values: organization, bucket, username, and password."
  value       = try(aws_timestreaminfluxdb_db_instance.this[0].influx_auth_parameters_secret_arn, "")
}
