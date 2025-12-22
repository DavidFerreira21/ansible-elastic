name_prefix = "asapflow-es"
region      = "us-east-1"
vpc_id      = "vpc-0e100cd44720c5ff5"
subnet_ids  = ["subnet-089bea911bd5d0efa"]
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
