#
# Cookbook Name:: sklad1
# Recipe:: magento
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

include_recipe 'docker_compose::installation'

group 'magento'
user 'magento' do
  group 'magento'
  comment 'Magento user'
  shell '/bin/bash'
  system true
end

# magento instances
quick_start = '/var/www/magento'
porto = '/var/www/porto'

[quick_start, porto].each do |inst|

  directory inst

  directory "#{inst}/src" do
    owner 'www-data'
    group 'www-data'
    recursive false
  end

  %w(var pub/static pub/media).each do |dir|
    directory "#{inst}/src/#{dir}" do
      mode 00777
      recursive true
    end
  end

  cookbook_file "#{inst}/perm.sh" do
    source 'magento/perm.sh'
  end
  
  magento_compose = "#{inst}/docker-compose.yml"

  app_name = File.basename(inst)

  cookbook_file magento_compose do
    source "magento/docker-compose.yml"
    mode 00640
    notifies :up, "docker_compose_application[#{app_name}]", :delayed
  end

  %w(composer global).each do |file|
    cookbook_file "#{inst}/#{file}.env" do
      source "magento/#{file}.env"
    end
  end

  docker_compose_application app_name do
    action :up
    compose_files [magento_compose]
  end
end
