#
# Cookbook Name:: atlasck
# Recipe:: webserver
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

java 'install java8'

tomcat_install 'atlasck' do
  version '8.5.4'
  install_path '/usr/local/apache-tomcat'
end
