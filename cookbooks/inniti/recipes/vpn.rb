#
# Cookbook Name:: inniti
# Recipe:: vpn
#
# Copyright (c) 2020 The Authors, All Rights Reserved.

package %w(strongswan strongswan-pki libstrongswan-extra-plugins)

vpnServerRootCer = Base64.decode64(decrypt_keys_data_bag_item(node['inniti']['secret_path'].to_s,
                                                              'inniti_vpn_server_root_cer'))

file '/etc/ipsec.d/cacerts/VpnServerRoot.cer' do
  content vpnServerRootCer
end
