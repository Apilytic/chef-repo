#
# Cookbook Name:: gsa
# Recipe:: default
#
# Copyright (c) 2019 The Authors, All Rights Reserved.

package %w(docker curl)

bash 'install docker-compose' do
  code <<-EOH
    curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod 0755 /usr/local/bin/docker-compose
  EOH
  not_if {File::exists?('/usr/local/bin/docker-compose')}
end

service 'docker' do
  action :start
end

group 'docker' do
  members 'ec2-user'
  append true
  action :modify
end
