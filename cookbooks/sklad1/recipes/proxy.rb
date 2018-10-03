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

service 'nginx' do
  action :nothing
end

%w(magento.conf proxy.conf).each do |conf|
  template "/etc/nginx/conf.d/#{conf}" do
    source "proxy/#{conf}.erb"
    notifies :reload, 'service[nginx]', :immediately
  end
end


