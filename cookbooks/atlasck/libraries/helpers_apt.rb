module AtlasckCookbook
    module Helpers
        module Apt
            def add_repo_java
                apt_repository 'java_repo' do
                    uri 'ppa:webupd8team/java'
                    distribution 'trusty'
                end

                bash 'java-licence-agree' do
                    code <<-EOH
                      echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
                      echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
                  EOH
                end
            end
        end
    end
end

Chef::Provider.send(:include, AtlasckCookbook::Helpers::Apt)
