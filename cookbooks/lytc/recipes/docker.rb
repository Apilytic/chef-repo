#
# Cookbook Name:: lytc
# Recipe:: docker
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

docker_service 'default' do
  action [:create, :start]
end