name_prefix = "asapflow-es"
region      = "us-east-1"
vpc_id      = "vpc-05011c679a6e0120e"
subnet_ids  = ["subnet-0912b2e647ab2a9aa"]
ebs_size    = 20
key_name    = "test"
ambiente    = "uat"

instance_type            = "t3.medium"
elasticsearch_node_count = 1

# Tags opcionais
tags = {
  Environment = "uat"
  Project     = "elasticsearch"
}
