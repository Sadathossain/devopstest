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
  content '-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEA0QJxs3oM0LG6FJbE/s0rgHAwEpU0B9+LwPyQizIjipwYFzWT
9W9mfGPg0MXutqdXsaKnX73FKH9IPdgRKM+516KFsyWQ5FVayjtnszGPl+HqBRIp
d+Tlk2ntfrSM1feymv94OOlMfIYVwMwPbW5umLsegKpj7DSdwJ9S/334xWzQMoUe
I5Id3H0319i0bC1fl+Ae9RoU+sSJQSokTXWEoF1MlvM5x921N/MGRv2mBOA7dpdL
oJlkL1axPH60CEbd3IZqLgpi7XPyzPFGyeyqH6+ML87PZD6IPBeQ07v+GAjd8TeP
tueJwKReHqlw8ZRtIQJIwlNbEmUvXJxROLE6uQIDAQABAoIBAEH1bYBgQe8SR1D8
C4sFoHbV8LXMlDDv4SC0E8F5vzGc9RVN+TV5RHR46Je5/w1xXgFW/U7/ilqvYFLz
/uZMN6/PQDY64rDMJuyvNpicSV57EukqxB9sAu80fJiBzfgwRRMZEA2VwmeBwReo
zi2QriJQ2t1r6EDAkhAZt42daYaTr6TlkNOyPIWFUK/Lmjvh/wK2C8FGkFL2mn1x
VaHAHhHBQFoVpIeYmw/jQUm8o031gTNYoSlKyLT1NSJsYXMBRp/QEO4u6FD8Hyr7
Jys8hrLgVMf8k7LZqwvXes5W/2Kg9Uqk2fXPrWhgg2F5SLy8VThNse3hgED1MBed
5wAqlQECgYEA/ypHr0L2O9KCb0QWU5BVGkspyV0TyHokrXjBzsEN1hwQT+iF/NOu
DWManX4lSIv0xW7jeBIFJlLUMkuCA06Y5nJpeuHRNe4z5GBT6z+6fUbQYXxMtMge
L6QUFwtpyKyBCzWTkbFr6A6QQ56xsJZb+ELhvWD3G/r5qGr2E5ettekCgYEA0bGB
XdRqd7c5EQxqZVI5bR9+uhxj2ya/0zd9NvyAo0d77DoZYex5GRVOO4TEf4EUROEV
4MC11dcwNNO0+WqAXu4Nk7K254iXEjkYBVXRAmX3muQDSKNWkAc10jATQgzV1GvZ
zdBJgsAKswVLX7vtpRvhr8B6sceQjIEJAkN9zFECgYAUgL810/mZIPceHah1mnlc
HYIEDhiS2U2tKrDX/icwdxzQbuylPhUUOkxfL02roKNQYfKhKUGErM8kI3EU9vHO
Qo87Mn3vCW7eAOd9VaeUfWYtDyHSvOnABj0fBOnBGCteTTXIVStIgDMTW+MHP22w
ax9cajgw5V++KqoPNPbeUQKBgQCGvTcyEm6DFEFf+glXp5jszGMCtYFYbTKvRqV3
spH52NIA/WgX6vn5Kx6E0g/tGgTrKXKEY2+zwzzfhPVxmoR3+yDQOfKbHcJs3DDa
JMVTdC/A4ChYAVR64ZcswuVs+JBhmRdvzxmdIUb+tzUyg6/0+tBuvRBZsbDpB3TB
dpqbsQKBgH5Zyh+p972KvFu6bV186vigzIStX8dm865TuO8hiYYPdltyTB50rS8e
49iDdhUzBwFqpsrVgqyErshMErtYKipTT9bhALR9HT9fZGq0PIb7Wl9Vw5BcNxH4
OzMiNKaa77oso36TOlaRU2AKCenxljYN9SJiOHkEOdLQPzF4QehD
-----END RSA PRIVATE KEY-----'
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
