#
# Cookbook Name:: atlasck
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'apt::default'

apt_package 'apt-transport-https' do
    options '--force-yes'
end

include_recipe 'atlasck::database'
include_recipe 'atlasck::webserver'
