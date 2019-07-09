#
# Cookbook Name:: gsa
# Recipe:: backups
#
# Copyright (c) 2019 The Authors, All Rights Reserved.

aws_user, aws_password = decrypt_passwords_data_bag_item(node['gsa']['secret_path'].to_s, 'gsa_backup_password')

tag_name = DateTime.now.strftime("%Y%m%d_%H%M%S")

bash 'backup postgres' do
  cwd '/var/www/gsa/docker'
  code <<-EOH
  docker-compose exec -T postgres pg_dump -U postgres postgres | gzip > gsa_prod-#{tag_name}.dump.gz
  EOH
end

bash 'sync backups' do
  environment ({AWS_ACCESS_KEY_ID: aws_user, AWS_SECRET_ACCESS_KEY: aws_password, AWS_DEFAULT_REGION: 'eu-west-1'})
  cwd '/var/www/gsa/docker'
  code <<-EOH
  aws s3 cp gsa_prod-#{tag_name}.dump.gz s3://gsa-db-backup/gsa_prod-#{tag_name}.dump.gz
  EOH
end