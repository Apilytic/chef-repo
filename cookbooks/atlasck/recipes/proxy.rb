#
# Cookbook Name:: atlasck
# Recipe:: proxy
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'nginx'

%w(tomcat atlasck.conf).each do|site|
    cookbook_file "/etc/nginx/sites-available/#{site}" do
        source site
    end

    link "/etc/nginx/sites-enabled/#{site}" do
        to "/etc/nginx/sites-available/#{site}"
        notifies :reload, 'service[nginx]'
    end
end

cookbook_file '/etc/nginx/htpasswd' do
    source 'htpasswd'
end

cookbook_file '/etc/nginx/conf.d/limit_req_zone.conf' do
    source 'limit_req_zone.conf'
end

service 'nginx' do
    action :nothing
end
