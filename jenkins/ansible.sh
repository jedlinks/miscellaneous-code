ssh_username=$(aws ssm get-parameter --name "ssh.username" --with-decryption --query 'Parameter.Value' --output text)
ssh_password=$(aws ssm get-parameter --name "ssh.password" --with-decryption --query 'Parameter.Value' --output text)

ansible-playbook -i 172.31.8.151, playbook.yml -e ansible_user=$ssh_username -e ansible_password=$ssh_password