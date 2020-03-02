#
# Cookbook Name:: inniti
# Recipe:: db_slave
#
# Copyright (c) 2020 The Authors, All Rights Reserved.

template '/var/www/inniti/docker/slave.cnf' do
  source 'db_slave/slave.cnf.erb'
  variables(server_id: node['inniti']['global_db']['server_id'])
  user node['inniti']['user']['name']
end

template '/var/www/inniti/docker/slave_setup.sh' do
  source 'db_slave/slave_setup.sh.erb'
  mode 00777
  user node['inniti']['user']['name']
  group node['inniti']['user']['name']
end