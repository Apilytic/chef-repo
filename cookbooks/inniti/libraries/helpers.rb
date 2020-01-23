module InnitiCookbook
  module Helpers
    def secret
      node['inniti']['secret_path'].to_s
    end
  end
end

Chef::Recipe.send(:include, InnitiCookbook::Helpers)