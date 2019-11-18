#
# Cookbook Name:: inniti
# Recipe:: service
#
# Copyright (c) 2019 The Authors, All Rights Reserved.

cwd = node['inniti']['flow']['dir']['target']

execute 'systemctl daemon-reload' do
  action :nothing
end

template '/etc/systemd/system/flow_mes.service' do
  source 'flow_mes/flow_mes.service.erb'
  variables(working_dir: cwd)
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

template "#{cwd}/start.sh" do
  source 'flow_mes/start.sh.erb'
end

execute 'systemctl enable flow_mes.service'


