#
# Cookbook Name:: inniti
# Recipe:: service_volume
#
# Copyright (c) 2020 The Authors, All Rights Reserved.

bash 'log volume' do
  code "docker volume create #{log_volume}"
  only_if { node['inniti']['docker']['volume']['create'] }
end