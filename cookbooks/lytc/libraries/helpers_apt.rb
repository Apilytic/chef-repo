module LytcCookbook
  module Helpers
    module Apt
      def add_repo_nginx
        apt_repository 'nginx_repo' do
          uri 'http://nginx.org/packages/debian/'
          keyserver 'keyserver.ubuntu.com'
          key 'ABF5BD827BD9BF62'
          components %w(nginx)
          distribution 'jessie'
          only_if {platform_family?('debian')}
        end
      end
    end
  end
end

Chef::Recipe.send(:include, LytcCookbook::Helpers::Apt)
