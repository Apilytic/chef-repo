#
# Cookbook Name:: wiki
# Recipe:: webserver
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'lytc::uwsgi'

cookbook_file '/etc/systemd/system/wiki.service' do
    source 'init/wiki.service'
end

directory 'wiki verify dir' do
    path '/home/www/moin'
    owner 'www-data'
    group 'www-data'
    recursive true
end

file '/home/www/moin/wiki.sock' do
    owner 'www-data'
    group 'www-data'
    mode 00660
    action :create_if_missing
end

logrotate_app 'wiki' do
    cookbook 'logrotate'
    path ['/home/www/moin/wiki/data/edit-log',
          '/home/www/moin/wiki/data/event-log']
    frequency 'daily'
    options %w(missingok compress delaycompress sharedscripts notifempty)
    rotate 30
    create '0644 www-data www-data'
end
