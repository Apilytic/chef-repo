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

tomcat_service 'atlasck' do
  action :enable
  env_vars [{'JAVA_HOME' => '/usr/lib/jvm/java-8-oracle',
             'CATALINA_OPTS' =>
                 '-server -Xms64m -Xmx128m -XX:MaxPermSize=96m -XX:+DisableExplicitGC'}]
end

logrotate_app 'tomcat_atlasck' do
  cookbook 'logrotate'
  path %w(/usr/local/apache-tomcat/logs/catalina.out
      /usr/local/apache-tomcat/logs/*.log
      /usr/local/apache-tomcat/logs/*.txt)
  frequency 'daily'
  options %w(missingok compress delaycompress sharedscripts notifempty)
  rotate 30
  create '0644 tomcat_atlasck tomcat_atlasck'
end
