#
# Cookbook:: chef-rocketchat
# Recipe:: nodejs
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'nodejs::npm'

nodejs_npm 'rocketchat' do
  path  "#{node['rocketchat']['install_dir']}/programs/server"
  json true
  user node['rocketchat']['user']
end
