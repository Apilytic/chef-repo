#
# Cookbook Name:: gitserver
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package %w(git gitolite3)

group 'git'

execute 'add git user' do
    command <<-EOH
adduser \
   --system \
   --shell /bin/bash \
   --gecos 'git version control' \
   --group git \
   --disabled-password \
   --home /home/git git
    EOH
end
