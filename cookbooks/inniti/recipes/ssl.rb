#
# Cookbook Name:: inniti
# Recipe:: ssl
#
# Copyright (c) 2020 The Authors, All Rights Reserved.

ssl_location = node['inniti']['ssl']['location']

%w(crt rsa).each do |cert|
  cert_name = "inniti_dk_ssl_#{cert}_key"
  content = decrypt_keys_data_bag_item(secret, cert_name)

  file "#{ssl_location}/inniti.#{cert}" do
    content content
    owner node['inniti']['user']['name']
    group node['inniti']['user']['name']
  end
end