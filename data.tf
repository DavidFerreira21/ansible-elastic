

data "aws_subnet" "selected" {
  for_each = toset(var.subnet_ids)
  id       = each.value
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  region          = data.aws_region.current.name
  account_id      = data.aws_caller_identity.current.account_id
  resource_prefix = "${var.ambiente}-${var.name_prefix}"
}