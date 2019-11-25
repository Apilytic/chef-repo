#
# Cookbook Name:: inniti
# Recipe:: deploy
#
# Copyright (c) 2019 The Authors, All Rights Reserved.

build_app = "#{node['inniti']['flow']['dir']['src']}/target/#{node['inniti']['flow']['jar']}"
deployed_app = "#{node['inniti']['flow']['dir']['target']}/#{node['inniti']['flow']['jar']}"

execute 'systemctl stop flow_mes.service'

remote_file deployed_app do
  source "file:///#{build_app}"
  user node['inniti']['user']['name']
  group node['inniti']['user']['name']
end

chef_sleep 'waiting for connection close' do
  seconds 60
end

execute 'systemctl start flow_mes.service'