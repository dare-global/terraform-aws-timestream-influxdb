output "cluster_id" {
  description = "ID of the Timestream for InfluxDB cluster"
  value       = try(aws_timestreaminfluxdb_db_cluster.this.id, "")
}

output "cluster_endpoint" {
  description = "Endpoint for the InfluxDB cluster"
  value       = try(aws_timestreaminfluxdb_db_cluster.this.endpoint, "")
}

output "cluster_arn" {
  description = "ARN of the InfluxDB cluster"
  value       = try(aws_timestreaminfluxdb_db_cluster.this.arn, "")
}

output "instance_id" {
  description = "ID of the Timestream for InfluxDB instance"
  value       = try(aws_timestreaminfluxdb_db_instance.this.id, "")
}

output "instance_endpoint" {
  description = "Endpoint for the InfluxDB instance"
  value       = try(aws_timestreaminfluxdb_db_instance.this.endpoint, "")
}

output "instance_arn" {
  description = "ARN of the InfluxDB instance"
  value       = try(aws_timestreaminfluxdb_db_instance.this.arn, "")
}
