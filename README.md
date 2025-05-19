# terraform-aws-timestream-influxdb

## Examples

* [InfluxDB cluster](https://github.com/dare-global/terraform-aws-timestream-influxdb/tree/main/examples/influxdb-cluster/)
* [InfluxDB instance](https://github.com/dare-global/terraform-aws-timestream-influxdb/tree/main/examples/influxdb-instance/)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.91.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.91.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_timestreaminfluxdb_db_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/timestreaminfluxdb_db_cluster) | resource |
| [aws_timestreaminfluxdb_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/timestreaminfluxdb_db_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | Amount of storage in GiB (gibibytes). The minimum value is 20, the maximum value is 16384. | `number` | `null` | no |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | Name of the initial InfluxDB bucket. All InfluxDB data is stored in a bucket. A bucket combines the concept of a database and a retention period (the duration of time that each data point persists). A bucket belongs to an organization. | `string` | `null` | no |
| <a name="input_db_instance_type"></a> [db\_instance\_type](#input\_db\_instance\_type) | The type of compute and memory capacity for the instance | `string` | `"db.influx.medium"` | no |
| <a name="input_db_storage_type"></a> [db\_storage\_type](#input\_db\_storage\_type) | The storage type to be used (e.g., 'InfluxIOPS', 'InfluxStandard') | `string` | `null` | no |
| <a name="input_deployment_type"></a> [deployment\_type](#input\_deployment\_type) | Deployment type, `SINGLE_AZ`, `WITH_MULTIAZ_STANDBY`, `MULTI_NODE_READ_REPLICAS`. | `string` | n/a | yes |
| <a name="input_failover_mode"></a> [failover\_mode](#input\_failover\_mode) | Specifies the behavior of failure recovery when the primary node of the cluster fails. Valid options are: 'AUTOMATIC' and 'NO\_FAILOVER'. | `string` | `null` | no |
| <a name="input_log_delivery_configuration"></a> [log\_delivery\_configuration](#input\_log\_delivery\_configuration) | Configuration for sending InfluxDB engine logs to a specified S3 bucket. This argument is updatable. | <pre>object({<br/>    s3_configuration = object({<br/>      bucket_name = string<br/>      enabled     = bool<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Unique identifier name for the Timestream for InfluxDB instance or cluster | `string` | n/a | yes |
| <a name="input_network_type"></a> [network\_type](#input\_network\_type) | Specifies whether the network type of the Timestream for InfluxDB cluster is IPV4, which can communicate over IPv4 protocol only, or DUAL, which can communicate over both IPv4 and IPv6 protocols. | `string` | `null` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | The organization name for InfluxDB | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | Password for accessing the InfluxDB instance | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | The port on which the cluster accepts connections. Valid values: `1024`-`65535`. Cannot be `2375`-`2376`, `7788`-`7799`, `8090`, or `51678`-`51680`. This argument is updatable. | `string` | `null` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Configures the DB instance/cluster with a public IP to facilitate access. Other resources, such as a VPC, a subnet, an internet gateway, and a route table with routes, are also required to enabled public access. | `bool` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the resources | `map(string)` | `{}` | no |
| <a name="input_username"></a> [username](#input\_username) | Username for accessing the InfluxDB instance | `string` | n/a | yes |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | List of security group IDs | `list(string)` | `[]` | no |
| <a name="input_vpc_subnet_ids"></a> [vpc\_subnet\_ids](#input\_vpc\_subnet\_ids) | List of VPC subnet IDs | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | ARN of the InfluxDB cluster |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for the InfluxDB cluster |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | ID of the Timestream for InfluxDB cluster |
| <a name="output_cluster_influx_auth_parameters_secret_arn"></a> [cluster\_influx\_auth\_parameters\_secret\_arn](#output\_cluster\_influx\_auth\_parameters\_secret\_arn) | ARN of the AWS Secrets Manager secret containing the initial InfluxDB authorization parameters. The secret value is a JSON formatted key-value pair holding InfluxDB authorization values: organization, bucket, username, and password. |
| <a name="output_cluster_reader_endpoint"></a> [cluster\_reader\_endpoint](#output\_cluster\_reader\_endpoint) | The endpoint used to connect to the Timestream for InfluxDB cluster for read-only operations. |
| <a name="output_instance_arn"></a> [instance\_arn](#output\_instance\_arn) | ARN of the InfluxDB instance |
| <a name="output_instance_endpoint"></a> [instance\_endpoint](#output\_instance\_endpoint) | Endpoint for the InfluxDB instance |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | ID of the Timestream for InfluxDB instance |
| <a name="output_instance_influx_auth_parameters_secret_arn"></a> [instance\_influx\_auth\_parameters\_secret\_arn](#output\_instance\_influx\_auth\_parameters\_secret\_arn) | ARN of the AWS Secrets Manager secret containing the initial InfluxDB authorization parameters. The secret value is a JSON formatted key-value pair holding InfluxDB authorization values: organization, bucket, username, and password. |
<!-- END_TF_DOCS -->

## License

See LICENSE file for full details.

## Maintainers

* [Marcin Cuber](https://github.com/marcincuber)

## Pre-commit hooks

### Install dependencies

* [`pre-commit`](https://pre-commit.com/#install)
* [`terraform-docs`](https://github.com/segmentio/terraform-docs) required for `terraform_docs` hooks.
* [`TFLint`](https://github.com/terraform-linters/tflint) required for `terraform_tflint` hook.

#### MacOS

```bash
brew install pre-commit terraform-docs tflint

brew tap git-chglog/git-chglog
brew install git-chglog
```
