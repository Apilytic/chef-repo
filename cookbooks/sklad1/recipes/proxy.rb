#
# Cookbook Name:: sklad1
# Recipe:: proxy
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

add_repo_nginx

include_recipe 'lytc::proxy'

execute 'unmask nginx service' do
  command 'systemctl unmask nginx.service'
  only_if {platform_family?('debian')}
end


%w(magento.conf).each do |site|
  cookbook_file "/etc/nginx/conf.d/#{site}" do
    source "proxy/#{site}"
    notifies :reload, 'service[nginx]', :immediately
  end
end
