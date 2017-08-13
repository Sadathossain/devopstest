#
# Copyright 2015-2017, Noah Kantrowitz
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe 'git'

node.default['nodejs']['install_method'] = 'binary'
node.default['nodejs']['version'] = '6.11.2'
node.default['nodejs']['binary']['checksum']['linux_x64'] = '1ca74833ff79e6a3a713a88bba8e7f5f5cda5d4008a6ffeb2293a1bf98f83e04'

include_recipe 'nodejs'

file '/root/.ssh/id_rsa' do
  mode '0400'
  content 'PRIVATE KEY'
end

git '/opt/app' do
  repository 'https://github.com/Sadathossain/helloworld_localdev_vagrant/'
  revision 'master'
end

execute 'npm prune' do
  cwd '/opt/app'
end

execute 'npm install' do
  cwd '/opt/app'
end

template '/etc/init/app.conf' do
  notifies :stop, 'service[app]', :delayed
  notifies :start, 'service[app]', :delayed
end

service 'app' do
  provider Chef::Provider::Service::Upstart
  action :start
  subscribes :restart, 'git[/opt/app]', :delayed
  subscribes :restart, 'execute[npm prune]', :delayed
  subscribes :restart, 'execute[npm install]', :delayed
end
