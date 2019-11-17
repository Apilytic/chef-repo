#
# Cookbook Name:: inniti
# Recipe:: build
#
# Copyright (c) 2019 The Authors, All Rights Reserved.

template_prop = "#{node['inniti']['flow']['dir']['src']}#{node['inniti']['flow']['config'][node.environment]}"
config = File.dirname(template_prop) + '/config.properties'

remote_file config do
  source "file:///#{template_prop}"
  user node['inniti']['user']['name']
end

bash 'build Flow_mess app' do
  cwd node['inniti']['flow']['dir']['src']
  code <<-EOH
source /etc/mavenrc
/usr/local/maven/bin/mvn clean package
  EOH
  user node['inniti']['user']['name']
end