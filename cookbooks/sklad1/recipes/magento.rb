#
# Cookbook Name:: sklad1
# Recipe:: magento
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

include_recipe 'docker_compose::installation'

directory '/var/www/magento'
directory '/var/www/magento/src' do
  owner 'magento'
  group 'magento'
  recursive true
end

magento_compose = '/var/www/magento/docker-compose.yml'

cookbook_file magento_compose do
  source "magento/docker-compose.yml"
  mode 00640
  notifies :up, 'docker_compose_application[magento]', :delayed
end

docker_compose_application 'magento' do
  action :up
  compose_files [magento_compose]
end

user 'magento' do
  comment 'Magento user'
  shell '/bin/bash'
  system true
end