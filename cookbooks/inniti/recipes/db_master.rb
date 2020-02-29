#
# Cookbook Name:: inniti
# Recipe:: db_master
#
# Copyright (c) 2020 The Authors, All Rights Reserved.

gem_package 'my_obfuscate'

db_user, db_password = decrypt_passwords_data_bag_item(secret, 'inniti_mysql_password')

bash 'initial db dump' do
  cwd '/var/www/inniti/docker'
  code <<-EOH
docker-compose exec -T mysql_app mysqldump --add-drop-table --hex-blob -u#{db_user} -p#{db_password} inniti > inniti.sql
  EOH
end
