variable "name" {
  description = "Unique identifier name for the Timestream for InfluxDB instance or cluster"
  type        = string
}

variable "db_cluster_type" {
  description = "The type of compute and memory capacity for the cluster"
  type        = string
}

variable "db_instance_type" {
  description = "The type of compute and memory capacity for the instance"
  type        = string
  default     = "db.influx.medium"
}

variable "db_storage_type" {
  description = "The storage type to be used (e.g., 'InfluxIOPS', 'InfluxStandard')"
  type        = string
  default     = null
}

variable "allocated_storage" {
  description = "Amount of storage in GiB (gibibytes). The minimum value is 20, the maximum value is 16384."
  type        = number
  default     = null
}

variable "organization" {
  description = "The organization name for InfluxDB"
  type        = string
}

variable "bucket" {
  description = "Name of the initial InfluxDB bucket. All InfluxDB data is stored in a bucket. A bucket combines the concept of a database and a retention period (the duration of time that each data point persists). A bucket belongs to an organization."
  type        = string
  default     = null
}

variable "username" {
  description = "Username for accessing the InfluxDB instance"
  type        = string
  sensitive   = true
}

variable "password" {
  description = "Password for accessing the InfluxDB instance"
  type        = string
  sensitive   = true
}

variable "vpc_subnet_ids" {
  description = "List of VPC subnet IDs"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = []
}

variable "deployment_type" {
  description = "Deployment type, `SINGLE_AZ`, `WITH_MULTIAZ_STANDBY`, `MULTI_NODE_READ_REPLICAS`."
  type        = string
}

variable "publicly_accessible" {
  description = "Configures the DB instance/cluster with a public IP to facilitate access. Other resources, such as a VPC, a subnet, an internet gateway, and a route table with routes, are also required to enabled public access."
  type        = bool
  default     = null
}

variable "log_delivery_configuration" {
  description = "Configuration for sending InfluxDB engine logs to a specified S3 bucket. This argument is updatable."
  type = object({
    s3_configuration = object({
      bucket_name = string
      enabled     = bool
    })
  })
  default = null
}

variable "failover_mode" {
  description = "Specifies the behavior of failure recovery when the primary node of the cluster fails. Valid options are: 'AUTOMATIC' and 'NO_FAILOVER'."
  type        = string
  default     = null
}

variable "network_type" {
  description = "Specifies whether the network type of the Timestream for InfluxDB cluster is IPV4, which can communicate over IPv4 protocol only, or DUAL, which can communicate over both IPv4 and IPv6 protocols."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}
