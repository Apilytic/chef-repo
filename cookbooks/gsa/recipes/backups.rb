#
# Cookbook Name:: gsa
# Recipe:: backups
#
# Copyright (c) 2019 The Authors, All Rights Reserved.

aws_user, aws_password = decrypt_passwords_data_bag_item(node['gsa']['secret_path'].to_s, 'gsa_backup_password')
mysql_user, mysql_password = decrypt_passwords_data_bag_item(node['gsa']['secret_path'].to_s,
                                                             'gsa_mysql_password')

tag_name = DateTime.now.strftime("%Y%m%d_%H%M%S")
mysql_backup_name = "gsa_prod_mysql-#{tag_name}.dump.gz"
postgres_backup_name = "gsa_prod_postgres-#{tag_name}.dump.gz"

bash 'backup databases' do
  cwd '/var/www/gsa/docker'
  code <<-EOH
  docker-compose exec -T postgres pg_dump -U postgres postgres | gzip > #{postgres_backup_name}
  docker-compose exec -T mysql mysqldump #{mysql_user} -u#{mysql_user} -p"#{mysql_password}" \
  --single-transaction --routines | gzip > #{mysql_backup_name}
  EOH
end

bash 'sync backups' do
  environment ({AWS_ACCESS_KEY_ID: aws_user, AWS_SECRET_ACCESS_KEY: aws_password, AWS_DEFAULT_REGION: 'eu-west-1'})
  cwd '/var/www/gsa/docker'
  code <<-EOH
  aws s3 cp #{postgres_backup_name} s3://gsa-db-backup/#{postgres_backup_name}
  aws s3 cp #{mysql_backup_name} s3://gsa-db-backup/#{mysql_backup_name}
  EOH
end