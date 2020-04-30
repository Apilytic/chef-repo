default['inniti']['flow']['dir']['src'] = '/var/www/inniti-backend/Flow_MES'
default['inniti']['flow']['dir']['target'] = '/home/inniti/app'
default['inniti']['flow']['dir']['repository'] = '/home/inniti/git'
default['inniti']['flow']['dir']['stage'] = '/var/www/inniti-backend'
default['inniti']['flow']['config']['path'] = '/src/resources'
default['inniti']['flow']['config']['name'] = 'config-office.properties'
default['inniti']['flow']['jar'] = 'Flow_MES-1.0-jar-with-dependencies.jar'
default['inniti']['user']['name'] = 'inniti'
default['inniti']['user']['home'] = '/home/inniti'

default['inniti']['service']['flow'] = true
default['inniti']['service']['local_flow'] = false
default['inniti']['service']['volume']['log'] = 'flow_mes_log'

default['inniti']['git']['branch'] = 'master'

default['inniti']['vpn']['dir']['stage'] = '/usr/local/etc/vpn'
default['inniti']['vpn']['server'] = 'inniti_vpn_server_name_key'
default['inniti']['vpn']['client'] = 'client'

default['inniti']['ssl']['location'] = '/var/www/inniti/docker/proxy/etc'

default['inniti']['global_db']['server_id'] = 2
default['inniti']['global_db']['master']['tables'] = %w(units
                                                        unit_types
                                                        unit_type_abilities
                                                        unit_type_live_abilities
                                                        unit_types_measurements
                                                        live_abilities
                                                        companies
                                                        abilities
                                                        )

default['inniti']['secret_path'] = '/etc/chef/encrypted_data_bag_secret'
