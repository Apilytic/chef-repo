#
# Cookbook Name:: sklad1
# Recipe:: magento
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

include_recipe 'docker_compose::installation'

directory '/var/www/magento'

cookbook_file '/var/www/magento/docker-compose.yml' do
  source "magento/docker-compose.yml"
end