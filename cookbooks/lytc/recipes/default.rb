#
# Cookbook Name:: lytc
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'apt::default'

apt_package 'apt-transport-https' do
    options '--force-yes'
end

package 'htop'
package 'vim'

file '/root/.vimrc' do
  content 'syntax on'
end
