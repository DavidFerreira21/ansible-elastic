resource "aws_instance" "elasticsearch" {
  count = var.elasticsearch_node_count

  ami                         = "ami-068c0051b15cdb816" # Amazon Linux 2 AMI (HVM), SSD Volume Type - us-east-1
  instance_type               = var.instance_type
  subnet_id                   = element(var.subnet_ids, count.index)
  vpc_security_group_ids      = [aws_security_group.elasticsearch.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  root_block_device {
    volume_size = 30 # mínimo recomendado
    volume_type = "gp3"
    encrypted   = true
  }

  tags = merge(var.tags, {
    Name = "${local.resource_prefix}-es-${count.index}"
  })
}

