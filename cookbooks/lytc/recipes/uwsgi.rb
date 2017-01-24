#
# Cookbook Name:: lytc
# Recipe:: uwsgi
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package ['build-essential', 'python', 'python-dev']

remote_file '/tmp/get-pip.py' do
  source 'https://bootstrap.pypa.io/get-pip.py'
  not_if { ::File.exist?('/usr/local/bin/pip') }
  notifies :run, 'execute[install pip]', :immediately
end

execute 'install pip' do
  command 'python /tmp/get-pip.py'
  action :nothing
end

execute 'install uwsgi' do
  command 'pip install uwsgi'
  not_if { ::File.exist?('/usr/local/bin/uwsgi') }
end

remote_file '/usr/local/src/libiconv-1.11.tar.gz' do
  source 'http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.11.tar.gz'
  not_if { ::File.exist?('/usr/local/libiconv/lib/libiconv.so') }
  notifies :run, 'execute[extract libiconv]'
end

execute 'extract libiconv' do
  command 'tar -xvzf libiconv-1.11.tar.gz'
  cwd '/usr/local/src'
  notifies :run, 'execute[install libiconv]'
  action :nothing
end

execute 'install libiconv' do
  command <<-EOH
./configure --prefix=/usr/local/libiconv
make && make install
    EOH
  cwd '/usr/local/src/libiconv-1.11'
  notifies :run, 'execute[cleanup libiconv]'
  action :nothing
end

execute 'cleanup libiconv' do
  command 'rm -rf /usr/local/src/libiconv*'
  action :nothing
end

link '/lib/libiconv.so.2' do
  to '/usr/local/libiconv/lib/libiconv.so.2'
end
