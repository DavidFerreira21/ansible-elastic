variable "region" {
  description = "AWS region to deploy into"
  type        = string
}

variable "vpc_id" {
  description = "Target VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de subnets privadas onde os nós serão criados (uma por nó)"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type for Elasticsearch nodes"
  type        = string
  default     = "t3.medium"
}

variable "ambiente" {
  description = "Ambiente (ex: prd, hml, dev) usado como prefixo de nomes"
  type        = string
}

variable "key_name" {
  description = "Nome do key pair existente para acesso SSH"
  type        = string
  default     = "test"
}

variable "ebs_size" {
  description = "Size (GiB) of the dedicated Elasticsearch data EBS volume"
  type        = number
  default     = 20 # within AWS free tier (<=30GiB)
}

variable "ebs_device_name" {
  description = "Device name to attach the Elasticsearch EBS volume as"
  type        = string
  default     = "/dev/sdf"
}

variable "name_prefix" {
  description = "Prefix used for resource naming"
  type        = string
  default     = "elastic"
}

variable "tags" {
  description = "Map of tags to apply to created resources"
  type        = map(string)
  default     = {}
}

variable "elasticsearch_node_count" {
  type    = number
  default = 1
}
