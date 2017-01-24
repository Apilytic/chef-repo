class Chef
  class Provider
    MONGODB_MAX_CONNS ||= 2048

    class MongoDb < Chef::Provider::LWRPBase
      provides :mongodb if defined?(provides)
      use_inline_resources if defined?(use_inline_resources)

      action :create do
        include_recipe 'mongodb::10gen_repo'

        package 'numactl'

        template '/etc/mongodb.conf' do
          source 'mongodb.conf.erb'
          mode '0644'
          variables(
            max_conns: MONGODB_MAX_CONNS
          )
        end

        logrotate_app 'mongodb' do
          cookbook 'logrotate'
          path '/var/log/mongodb/*.log'
          frequency 'weekly'
          options %w(missingok compress delaycompress sharedscripts notifempty)
          rotate 52
          create '0644 mongodb nogroup'
        end
      end
    end
  end
end
