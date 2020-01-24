module InnitiCookbook
  module Helpers
    PASSWORD_RAND ||= ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a

    def secret
      node['inniti']['secret_path'].to_s
    end

    def unique_password(length = 10)
      PASSWORD_RAND.sort_by {rand}.join[0...length]
    end
  end
end

Chef::Recipe.send(:include, InnitiCookbook::Helpers)