resource "aws_security_group" "elasticsearch" {
  name        = "${local.resource_prefix}-elasticsearch"
  description = "Elasticsearch node access"
  vpc_id      = var.vpc_id

  ingress {
    description = "Elasticsearch HTTP"
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "Elasticsearch HTTP"
    from_port   = 9300
    to_port     = 9300
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "SSH from bastion/VPN"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound to VPC/internet via NAT"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${local.resource_prefix}-elasticsearch"
  })
}
