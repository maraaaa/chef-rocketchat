#
# Cookbook:: chef-rocketchat
# Recipe:: install
#
# installs/configures rocketchat application
#
# Copyright 2016, Greg Fitzgerald
# Copyright 2017, JJ Asghar
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

tar_name = tar_file(node['rocketchat']['url'])

remote_file "#{Chef::Config['file_cache_path']}/#{tar_name}" do
  source node['rocketchat']['url']
  checksum node['rocketchat']['checksum']
  owner node['rocketchat']['user']
  group node['rocketchat']['group']
  mode '0644'
  action :create_if_missing
end

directory node['rocketchat']['install_dir'] do
  owner node['rocketchat']['user']
  group node['rocketchat']['group']
  mode '0755'
  action :create
end

directory "#{Chef::Config['file_cache_path']}/rocketchat" do
  owner node['rocketchat']['user']
  group node['rocketchat']['group']
  mode '0755'
  action :create
end

execute 'Extract Rocket.Chat' do
  cwd Chef::Config['file_cache_path']
  command "tar xf #{Chef::Config['file_cache_path']}/#{tar_name} -C rocketchat"
  user node['rocketchat']['user']
  group node['rocketchat']['group']
end

directory node['rocketchat']['install_dir'] do
  recursive true
  owner node['rocketchat']['user']
  group node['rocketchat']['group']
  mode '0755'
  action :create
end

execute 'mv bundle dir' do
  command "cp -a #{Chef::Config['file_cache_path']}/rocketchat/bundle/* #{node['rocketchat']['install_dir']}"
end

execute 'npm install' do
  command 'npm install'
  cwd "#{node['rocketchat']['install_dir']}/programs/server"
end

template '/srv/rocketchat/.node_version.txt' do
  source 'node_version.erb'
  owner 'rocketchat'
  group 'rocketchat'
  mode '0644'
  variables(
    node_version: node['rocketchat']['node_version']
  )
end
