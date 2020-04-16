#
# Cookbook Name:: inniti
# Recipe:: service
#
# Copyright (c) 2019 The Authors, All Rights Reserved.

cwd = node['inniti']['flow']['dir']['target']
log_volume = node['inniti']['service']['volume']['log']

directory cwd do
  owner node['inniti']['user']['name']
  group node['inniti']['user']['name']
end

execute 'systemctl daemon-reload' do
  action :nothing
end

bash 'log volume' do
  code "docker volume create #{log_volume}"
end

template '/etc/systemd/system/flow_mes.service' do
  source 'flow_mes/flow_mes.service.erb'
  variables(working_dir: cwd)
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

start_service = node['inniti']['service']['local_flow'] ? 'flow_mes/start_local_flow.sh.erb' : 'flow_mes/start.sh.erb'

template "#{cwd}/start.sh" do
  source start_service
  variables(log_volume: log_volume)
  mode 00777
end

execute 'systemctl enable flow_mes.service'