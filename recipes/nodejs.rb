#
# Cookbook:: chef-rocketchat
# Recipe:: nodejs
#
# Copyright:: 2017, The Authors, All Rights Reserved.

nvm_install "node #{node['rocketchat']['node_version']}" do
  version node['rocketchat']['node_version']
  user node['rocketchat']['user']
  group node['rocketchat']['group']
  from_source false
  alias_as_default true
  action :create
end
