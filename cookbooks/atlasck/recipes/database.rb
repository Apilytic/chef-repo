#
# Cookbook Name:: atlasck
# Recipe:: database
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

password_secret = Chef::EncryptedDataBagItem.load_secret("#{node['atlasck']['secret_path']}")
root_password_data_bag_item = Chef::EncryptedDataBagItem.load('passwords', 'mysql_root_password',
                                                              password_secret)

mysql_service 'atlasck' do
    port '3306'
    initial_root_password root_password_data_bag_item['password']
    action [:create, :start]
end

mysql_config 'extra' do
    instance 'atlasck'
    source 'extra.cnf.erb'
    action :create
    notifies :restart, 'mysql_service[atlasck]'
end

template '/root/.my.cnf' do
    source 'my.cnf.erb'
    variables(
                  password: root_password_data_bag_item['password']
              )
    mode 0600
end
