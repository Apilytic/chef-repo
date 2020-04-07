#
# Cookbook Name:: inniti
# Recipe:: proxy_mysql
#
# Copyright (c) 2020 The Authors, All Rights Reserved.

package 'socat'

target = decrypt_keys_data_bag_item(secret, 'inniti_global_db_name_key')
user = node['inniti']['user']['name']

template '/usr/local/etc/proxy_global_db.sh' do
  source 'mysql/proxy.sh.erb'
  variables(user: user, group: user, target: target, in_port: 3336, dst_port: 3306)
  mode 00700
end

execute 'systemctl daemon-reload' do
  action :nothing
end

template '/etc/systemd/system/proxy_global_db.service' do
  source 'mysql/proxy_global_db.service.erb'
  variables(description: 'Proxy Global-db service', working_directory: '/usr/local/etc',
            user: 'root', execute_start: '/proxy_global_db.sh start', execute_stop: '/proxy_global_db.sh stop')
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

execute 'systemctl enable proxy_global_db.service'