#
# Cookbook Name:: inniti
# Recipe:: db_slave
#
# Copyright (c) 2020 The Authors, All Rights Reserved.

slave_user, slave_password = decrypt_passwords_data_bag_item(secret, 'inniti_mysql_slave_password')

template '/var/www/inniti/docker/slave.cnf' do
  source 'db_slave/slave.cnf.erb'
  variables(server_id: node['inniti']['global_db']['server_id'])
  user node['inniti']['user']['name']
end

template '/var/www/inniti/docker/slave_setup.sh' do
  source 'db_slave/slave_setup.sh.erb'
  mode 00777
  user node['inniti']['user']['name']
end

template '/var/www/inniti/docker/change_master.sql' do
  source 'db_slave/change_master.sql.erb'
  variables(user: slave_user, password: slave_password)
  user node['inniti']['user']['name']
  group node['inniti']['user']['name']
end