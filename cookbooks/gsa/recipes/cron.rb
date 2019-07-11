#
# Cookbook Name:: gsa
# Recipe:: cron
#
# Copyright (c) 2019 The Authors, All Rights Reserved.

cookbook_file '/etc/cron.d/gsa_backup' do
  source 'default/gsa_backup'
  notifies :restart, 'service[crond]'
end

cookbook_file '/etc/cron.d/gsa_reboot' do
  source 'default/gsa_reboot'
  notifies :restart, 'service[crond]'
end

service 'crond' do
  action :nothing
end