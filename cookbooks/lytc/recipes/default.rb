#
# Cookbook Name:: lytc
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'apt::default' if platform_family?('debian')

apt_package 'apt-transport-https' do
  options '--force-yes'
  only_if { platform_family?('debian') }
end

include_recipe 'htop::default'
package 'vim'

file '/root/.vimrc' do
  content 'syntax on'
end

# TODO: swap configuration
