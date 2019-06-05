#
# Cookbook Name:: gsa
# Recipe:: webserver
#
# Copyright (c) 2019 The Authors, All Rights Reserved.

bash 'start docker containers' do
  cwd '/var/www/gsa/docker'
  code 'docker-compose start'
end