#
# Cookbook Name:: inniti
# Recipe:: vpn
#
# Copyright (c) 2020 The Authors, All Rights Reserved.

package %w(strongswan strongswan-pki libstrongswan-extra-plugins)

vpnServerRootCer = Base64.decode64(decrypt_keys_data_bag_item(secret,
                                                              'inniti_vpn_VpnServerRoot_key'))

file '/etc/ipsec.d/cacerts/VpnServerRoot.cer' do
  content vpnServerRootCer
end

vpn_cwd = node['inniti']['vpn']['dir']['stage']

directory(vpn_cwd) {recursive true}

%w(caCert caKey).each do |cert|
  content = decrypt_keys_data_bag_item(secret, "inniti_vpn_#{cert}_key")
  file("#{vpn_cwd}/#{cert}.pem") {content content}
end

