#
# Cookbook:: chef-rocketchat
# Recipe:: service
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'runit'
runit_service 'rocketchat' do
  options({
    install_dir: node['rocketchat']['install_dir'],
    user: node['rocketchat']['user'],
    group: node['rocketchat']['group'],
    root_url: node['rocketchat']['root_url'],
    mongo_url: node['rocketchat']['mongo_url'],
    port: node['rocketchat']['port']
  }.merge(params))
  action [:enable, :start]
end
