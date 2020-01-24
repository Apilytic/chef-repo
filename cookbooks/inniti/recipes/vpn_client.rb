#
# Cookbook Name:: inniti
# Recipe:: vpn_client
#
# Copyright (c) 2020 The Authors, All Rights Reserved.

client = node['inniti']['vpn']['client']
password = unique_password
vpn_server = decrypt_keys_data_bag_item(secret, node['inniti']['vpn']['server'])
vpn_cwd = node['inniti']['vpn']['dir']['stage']

bash 'generate client certificate' do
  cwd vpn_cwd
  environment 'USERNAME' => client
  code <<-EOH
ipsec pki --gen --outform pem > "${USERNAME}Key.pem"
ipsec pki --pub --in "${USERNAME}Key.pem" | ipsec pki --issue --cacert caCert.pem --cakey caKey.pem \
--dn "CN=${USERNAME}" --san "${USERNAME}" --flag clientAuth --outform pem > "${USERNAME}Cert.pem"
  EOH
end

bash 'convert client cert to p12' do
  cwd vpn_cwd
  environment 'USERNAME' => client, 'PASSWORD' => password
  code <<-EOH
openssl pkcs12 -in "${USERNAME}Cert.pem" -inkey "${USERNAME}Key.pem" -certfile caCert.pem \
-export -out "${USERNAME}.p12" -password "pass:${PASSWORD}"
  EOH
end

remote_file "/etc/ipsec.d/private/#{client}.p12" do
  source "file:///#{vpn_cwd}/#{client}.p12"
end

template '/etc/ipsec.conf' do
  source 'ipsec/ipsec.conf.erb'
  variables(client: client, vpn_server: vpn_server)
  notifies :run, 'execute[ipsec restart]'
end

template '/etc/ipsec.secrets' do
  source 'ipsec/ipsec.secrets.erb'
  variables(client: client, password: password)
  notifies :run, 'execute[ipsec restart]'
end

directory(vpn_cwd) {action :nothing}

execute 'ipsec restart' do
  action :nothing
end

directory(vpn_cwd) {action :delete}