class Chef
    class Resource
        class Java < Chef::Resource::LWRPBase
            provides :java
            self.resource_name = :java

            actions :create
            default_action :create
        end
    end
end
