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
    env_vars [{ 'JAVA_HOME' => '/usr/lib/jvm/java-8-oracle',
                'CATALINA_OPTS' =>
      '-server -Xms64m -Xmx128m -XX:MaxPermSize=96m -XX:+DisableExplicitGC' }]
end

#TODO logrotate
