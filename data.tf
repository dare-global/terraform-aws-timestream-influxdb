data "aws_subnet" "this" {
  id = var.vpc_subnet_ids[0]
}
