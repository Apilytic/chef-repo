#
# Cookbook Name:: sklad1
# Recipe:: proxy
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

%w(magento.conf).each do |site|
  cookbook_file "/etc/nginx/sites-available/#{site}" do
    source "proxy/#{site}"
  end

  link "/etc/nginx/sites-enabled/#{site}" do
    to "/etc/nginx/sites-available/#{site}"
    notifies :reload, 'service[nginx]'
  end
end
