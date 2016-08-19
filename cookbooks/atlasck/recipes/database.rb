#
# Cookbook Name:: atlasck
# Recipe:: database
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

mysql_version = '5.5.50-0+deb8u1'

password_secret = Chef::EncryptedDataBagItem.load_secret("#{node['atlasck']['secret_path']}")
root_password_data_bag_item = Chef::EncryptedDataBagItem.load('passwords', 'mysql_root_password',
                                                              password_secret)

mysql_service 'atlasck' do
    port '3306'
    initial_root_password root_password_data_bag_item['password']
    package_version mysql_version
    action [:create, :start]
end

mysql_client 'atlasck' do
    package_version mysql_version
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

execute 'disable system mysql servce' do
    command 'update-rc.d mysql disable'
end

package 'libmysqlclient-dev'

include_recipe 'build-essential::default'
gem_package 'mysql2' do
    gem_binary RbConfig::CONFIG['bindir'] + '/gem'
    version '0.3.17'
end

mysql_connection_info = {
    host: 'localhost',
    username: 'root',
    socket: '/var/run/mysql-atlasck/mysqld.sock',
    password: root_password_data_bag_item['password']
}

atlasck_password_data_bag_item = Chef::EncryptedDataBagItem.load(
  'passwords',
  'mysql_atlasck_password',
  password_secret)

mysql_database_user atlasck_password_data_bag_item['user'] do
    connection mysql_connection_info
    password atlasck_password_data_bag_item['password']
    database_name 'atlasck'
    host 'localhost'
    privileges [:all]
    action [:create, :grant]
end
