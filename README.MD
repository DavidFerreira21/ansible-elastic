Terraform + Ansible para Elasticsearch simples na AWS
====================================================

Infra minimalista para subir uma EC2 Amazon Linux 2 com volume gp3 dedicado e instalar um nó único do Elasticsearch 8 via Ansible. O Terraform cria instância, EBS, Security Group e já gera o inventário do Ansible; o playbook instala e configura o serviço com segurança básica.

Visão geral do repositório
--------------------------
- Terraform (raiz): `providers.tf`, `variables.tf`, `data.tf`, `security_groups.tf`, `main.tf`, `outputs.tf`, `terraform.tfvars`, `inventory.tpl`.
- Ansible (`ansible-elastic/`): `ansible.cfg`, inventário em `inventory/host.yml`, `playbook.yml` e role `roles/elasticsearch`.

O que o Terraform provisiona
----------------------------
- EC2 `aws_instance.elasticsearch` (Amazon Linux 2) com volume root + volume gp3 extra (`aws_ebs_volume.elasticsearch_data`).
- Security Group abrindo 9200/9300 intra-SG e SSH (ajuste o CIDR conforme seu acesso).
- Output `ansible_inventory` com YAML pronto para o Ansible via `inventory.tpl`.

O que a role Ansible faz
------------------------
- Instala Java 17 e Elasticsearch 8 do repositório oficial.
- Renderiza `elasticsearch.yml` para nó único (abre 9200/0.0.0.0, discovery single-node, xpack.security ativo).
- Pede senha do usuário `elastic` (bootstrap) e cria usuário de aplicação (`elasticsearch_app_user`) com senha informada.
- Habilita e sobe o serviço.

Pré-requisitos
--------------
- Terraform >= 1.5 e Ansible >= 2.15.
- Credenciais AWS configuradas (CLI ou variáveis de ambiente).
- Par de chaves EC2 existente; tenha o `.pem` local para usar no Ansible.

Como usar
---------
1. Ajuste `terraform.tfvars` (região, `vpc_id`, `subnet_ids`, `instance_type`, `key_name`, `ebs_size`, `elasticsearch_node_count`, `tags`).
2. Provisione:
   ```bash
   terraform init
   terraform plan -var-file=terraform.tfvars
   terraform apply -var-file=terraform.tfvars
   ```
3. Gere o inventário Ansible:
   ```bash
   terraform output -raw ansible_inventory > ansible-elastic/inventory/host.yml
   ```
4. Execute o playbook (passe a chave SSH via CLI):
   ```bash
   cd ansible-elastic
   ansible-playbook -i inventory/host.yml playbook.yml -u ec2-user --key-file ~/.ssh/sua-chave.pem
   ```
   O playbook vai solicitar as senhas do usuário `elastic` e do usuário de aplicação.

Variáveis e outputs úteis
-------------------------
- Variáveis: `region`, `vpc_id`, `subnet_ids`, `instance_type`, `key_name`, `ebs_size`, `ebs_device_name` (default `/dev/sdf`), `elasticsearch_node_count`, `name_prefix`, `tags`.
- Outputs: `instance_id`, `ebs_volume_id`, `elasticsearch_private_ips`, `ansible_inventory` (conteúdo YAML do inventário).

Observações
-----------
- Ajuste o Security Group para CIDRs/SGs específicos de SSH e HTTP conforme a política da sua rede.
- O inventário gerado não inclui a chave SSH; escolha a chave no comando do Ansible (ou configure em `ansible.cfg` se preferir).
