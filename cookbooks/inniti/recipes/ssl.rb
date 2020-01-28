#
# Cookbook Name:: inniti
# Recipe:: ssl
#
# Copyright (c) 2020 The Authors, All Rights Reserved.

%w(crt rsa).each do |cert|
  cert_name = "inniti_dk_ssl_#{cert}_key"
  content = decrypt_keys_data_bag_item(secret, cert_name)

  file "/var/www/inniti/docker/proxy/etc/inniti.#{cert}" do
    content content
    owner node['inniti']['user']['name']
    group node['inniti']['user']['name']
  end
end