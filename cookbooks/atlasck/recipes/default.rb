#
# Cookbook Name:: atlasck
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'atlasck::database'
include_recipe 'atlasck::webserver'
include_recipe 'atlasck::proxy'
