
output "private_ssh_key" {
  value     = module.webserver.private_ssh_key
  sensitive = true
}

output "ssh_commands" {
  value = <<EOF
terraform output -json | jq -r .private_ssh_key.value > id_rsa.pem && \
chmod 0600 id_rsa.pem && \
ssh -i id_rsa.pem adminuser@${module.webserver.public_ip}
EOF

}

output "public_ip" {
  value = module.webserver.public_ip
}

output "public_url" {
  value = module.webserver.public_url
}


