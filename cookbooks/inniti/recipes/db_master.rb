#
# Cookbook Name:: inniti
# Recipe:: db_master
#
# Copyright (c) 2020 The Authors, All Rights Reserved.

gem_package 'my_obfuscate'

db_user, db_password = decrypt_passwords_data_bag_item(secret, 'inniti_mysql_password')
slave_user, slave_password = decrypt_passwords_data_bag_item(secret, 'inniti_mysql_slave_password')

bash 'initial db dump' do
  cwd '/var/www/inniti/docker'
  code <<-EOH
docker-compose exec -T mysql_app mysqldump -c --single-transaction --add-drop-table \
--hex-blob --skip-add-drop-table inniti \
units unit_types unit_type_abilities unit_types_measurements abilities \
ability_units -u#{db_user} -p#{db_password} > inniti.sql
  EOH
  sensitive true
end

template '/var/www/inniti/docker/replication_user.sql' do
  source 'db_master/replication_user.sql.erb'
  variables(user: slave_user, password: slave_password)
  user node['inniti']['user']['name']
  group node['inniti']['user']['name']
end

template '/var/www/inniti/docker/post_import.sql' do
  source 'db_master/post_import.sql.erb'
  user node['inniti']['user']['name']
  group node['inniti']['user']['name']
end
