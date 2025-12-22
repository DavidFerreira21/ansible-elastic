output "instance_id" {
  description = "Elasticsearch EC2 instance IDs"
  value       = aws_instance.elasticsearch[*].id
}



output "ansible_inventory" {
  value = templatefile("${path.module}/inventory.tpl", {
    nodes = aws_instance.elasticsearch[*]
  })
}

output "elasticsearch_private_ips" {
  description = "IPs privados das instâncias Elasticsearch"
  value       = aws_instance.elasticsearch[*].private_ip
}
