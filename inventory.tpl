all:
  children:
    elasticsearch:
      hosts:
%{ for idx, node in nodes ~}
        es${idx + 1}:
          ansible_host: ${node.private_ip}
          ansible_user: ec2-user
          ansible_python_interpreter: /usr/bin/python3
%{ endfor ~}
