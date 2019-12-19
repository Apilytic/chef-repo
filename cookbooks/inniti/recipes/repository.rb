#
# Cookbook Name:: inniti
# Recipe:: repository
#
# Copyright (c) 2019 The Authors, All Rights Reserved.

package 'git'

repo_dir = node['inniti']['flow']['dir']['repository']
user = node['inniti']['user']['name']
branch = node['inniti']['git']['branch']

directory repo_dir do
  recursive true
  owner user
  group user
end

%w(FLOW).each do |repo|
  wrapper = "#{repo_dir}/git_wrapper_#{repo}.sh"

  content = decrypt_keys_data_bag_item(node['inniti']['secret_path'].to_s, 'inniti_flow_mes_deploy_key')
  file "#{node['inniti']['user']['home']}/.ssh/deployer-#{repo}" do
    content content
    mode 0600
    owner user
    group user
  end

  file wrapper do
    owner user
    group user
    mode 00755
    content "#!/bin/sh\nexec /usr/bin/ssh -o UserKnownHostsFile=/dev/null "\
        '-o StrictHostKeyChecking=no '\
        "-i #{node['inniti']['user']['home']}/.ssh/deployer-#{repo} \"$@\""
  end

  git "#{repo_dir}/#{repo}" do
    repository "git@gitlab.com:INNITI/#{repo}.git"
    reference branch
    ssh_wrapper wrapper
    user user
    group user
  end

  execute "sync #{repo}" do
    command "rsync -avzpr --delete --exclude .git --exclude .idea #{repo_dir}/#{repo}/ #{node['inniti']['flow']['dir']['stage']}"
    user user
    group user
  end
end