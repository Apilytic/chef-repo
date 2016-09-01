#
# Cookbook Name:: zikraft
# Recipe:: webserver
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'lytc::uwsgi'

cookbook_file '/etc/systemd/system/zikraft.service' do
    source 'init/zikraft.service'
end

directory '/home/www/moin' do
    owner 'www-data'
    group 'www-data'
    recursive true
end

file '/home/www/moin/zikraft.sock' do
    owner 'www-data'
    group 'www-data'
    mode 00660
    action :create_if_missing
end

# provision virtual env
# install depedencies for zikraft
