class Chef
    class Provider
        class Java < Chef::Provider::LWRPBase
            provides :java if defined?(provides)
            use_inline_resources if defined?(use_inline_resources)

            action :create do
                add_repo_java
                package 'oracle-java8-installer'
            end
        end
    end
end
