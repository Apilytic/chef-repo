class Chef
    class Resource
        class MongoDb < Chef::Resource::LWRPBase
            provides :mongodb
            self.resource_name = :mongodb

            actions :create
            default_action :create
        end
    end
end
