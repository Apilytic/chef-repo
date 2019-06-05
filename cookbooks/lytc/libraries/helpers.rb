module LytcCookbook
  module Helpers
    def encrypted_password_secret(secret_path)
      Chef::EncryptedDataBagItem.load_secret(secret_path)
    end

    def decrypt_passwords_data_bag_item(secret_path, item)
      secret = encrypted_password_secret(secret_path)
      data_bag_item = Chef::EncryptedDataBagItem.load('passwords', item,
                                                      secret)
      if data_bag_item['user']
        return data_bag_item['user'], data_bag_item['password']
      end
      data_bag_item['password']
    end
  end
end

Chef::Recipe.send(:include, LytcCookbook::Helpers)