#
# Cookbook Name:: inniti
# Recipe:: service
#
# Copyright (c) 2019 The Authors, All Rights Reserved.

cwd = node['inniti']['flow']['dir']['target']

directory cwd do
  owner node['inniti']['user']['name']
  group node['inniti']['user']['name']
end

execute 'systemctl daemon-reload' do
  action :nothing
end

start_service = 'flow_mes/start.sh.erb'

if node['inniti']['service']['local_flow']
  start_service = 'flow_mes/start_local_flow.sh.erb'
end

template '/etc/systemd/system/flow_mes.service' do
  source 'flow_mes/flow_mes.service.erb'
  variables(working_dir: cwd)
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

template "#{cwd}/start.sh" do
  source start_service
  mode 00777
end

execute 'systemctl enable flow_mes.service'