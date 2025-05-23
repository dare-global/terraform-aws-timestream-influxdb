provider "aws" {
  region = "eu-west-2"
}

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.91.0"
    }
  }
}

#####
# VPC and subnets
#####
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

#####
# Security group
#####
resource "aws_security_group" "influxdb_instance" {
  name   = "influxdb-instance-sg"
  vpc_id = data.aws_vpc.default.id
}

resource "aws_vpc_security_group_ingress_rule" "influxdb_instance" {
  security_group_id = aws_security_group.influxdb_instance.id
  cidr_ipv4         = "172.31.0.0/16"
  ip_protocol       = "tcp"
  from_port         = 8086
  to_port           = 8086
}

#####
# Timestream InfluxDB
#####
module "influxdb_instance" {
  source = "../.."

  name            = "my-influxdb-instance"
  deployment_type = "SINGLE_AZ"

  db_instance_type = "db.influx.medium"
  db_storage_type  = "InfluxIOIncludedT1"

  organization = "myorg"
  bucket       = "initial"
  username     = "admin"
  password     = "supersecurepassword"

  vpc_subnet_ids         = data.aws_subnets.all.ids
  vpc_security_group_ids = [aws_security_group.influxdb_instance.id]
  ingress_cidr_blocks    = ["10.0.0.0/16"]

  publicly_accessible = false

  log_delivery_configuration = {
    s3_configuration = {
      bucket_name = aws_s3_bucket.influxdb_instance.id
      enabled     = true
    }
  }

  tags = {
    Environment = "test"
    Project     = "influxdb_instance"
  }
}

#####
# s3
#####
resource "aws_s3_bucket" "influxdb_instance" {
  bucket = "influxdb-instance-s3-bucket-test"

  force_destroy = true
}

data "aws_iam_policy_document" "influxdb_instance" {
  statement {
    actions = ["s3:PutObject"]
    principals {
      type        = "Service"
      identifiers = ["timestream-influxdb.amazonaws.com"]
    }
    resources = [
      "${aws_s3_bucket.influxdb_instance.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "influxdb_instance" {
  bucket = aws_s3_bucket.influxdb_instance.id
  policy = data.aws_iam_policy_document.influxdb_instance.json
}
