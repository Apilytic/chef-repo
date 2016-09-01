#
# Cookbook Name:: atlasck
# Recipe:: proxy
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'nginx'

template '/etc/nginx/sites-available/tomcat' do
    source 'tomcat.erb'
end

link '/etc/nginx/sites-enabled/tomcat' do
    to '/etc/nginx/sites-available/tomcat'
    notifies :reload, 'service[nginx]'
end

service 'nginx' do
    action :nothing
end
