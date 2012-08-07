#
# Cookbook Name:: apt-mirror
# Recipe:: mirror_apache2
#
# Author: Paul Thomas <paul.thomas@livingsocial.com>
#
# Copyright 2012, LivingSocial
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe "apache2"

apache_module "vhost_alias"

host_name = node['apt-mirror']['http']['host_name'] || node['fqdn']

cookbook_file "#{node['apt-mirror']['mirrorpath']}/index.html" do
  source "mirror-index.html"
  owner "apt-mirror"
  group "apt-mirror"
  mode "0644"
  action :create_if_missing
end

template "#{node['apache']['dir']}/sites-available/apt-mirror" do
  source "apache_mirror.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :host_name => host_name,
    :host_aliases => node['apt-mirror']['http']['host_aliases'],
    :docroot => node['apt-mirror']['mirrorpath']
  )

  if File.exists?("#{node['apache']['dir']}/sites-enabled/apt-mirror")
    notifies :restart, 'service[apache2]'
  end
end

apache_site "000-default" do
  enable false
end

apache_site "apt-mirror" do
  if node['apt-mirror']['http']['variant'] == "apache2"
    enable true
  else
    enable false
  end
end
