#
# Cookbook Name:: rocketchat
# Attributes:: default
#
# Copyright 2016, Greg Fitzgerald.
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['rocketchat']['user'] = 'rocketchat'
default['rocketchat']['group'] = 'rocketchat'
default['rocketchat']['install_dir'] = '/srv/rocketchat'

default['rocketchat']['url'] = 'https://rocket.chat/releases/0.53.0/download'
default['rocketchat']['checksum'] = '095c9476806186cb7ecd94490f43fe1496806b14edc8f4a3739840a895ee18a1'

default['nodejs']['install_method'] = 'binary'
default['nodejs']['version'] = '7.10.0'
default['nodejs']['binary']['checksum'] = '6166b9f3fb1a9e861335d864688fee5366f040db808080856a1a2b71b6019786'

case node['platform']
when 'debian'
  default['rocketchat']['dependencies'] = %w(git netcat graphicsmagick curl build-essential g++)
when 'ubuntu'
  default['rocketchat']['dependencies'] = %w(git graphicsmagick curl build-essential g++)
when 'redhat', 'centos', 'fedora'
  default['rocketchat']['dependencies'] = %w(git GraphicsMagick curl)
else
  default['rocketchat']['dependencies'] = %w(git graphicsmagick curl)
end

# runit service settings
default['rocketchat']['root_url'] = "http://#{node['fqdn']}:3000"
default['rocketchat']['mongo_url'] = 'mongodb://localhost:27017/rocketchat'
default['rocketchat']['port'] = 3000
