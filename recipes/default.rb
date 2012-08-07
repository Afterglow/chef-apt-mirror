#
# Cookbook Name:: apt-mirror
# Recipe:: default
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

package "apt-mirror" do
  action [:install]
end

mirrorfile = File.join("/etc/apt/", "mirror.list")
  
node['apt-mirror']['basepath'] ||= "/var/spool/apt-mirror"
node['apt-mirror']['mirrorpath'] ||= "$base_path/mirror"
node['apt-mirror']['skelpath'] ||= "$base_path/skel"
node['apt-mirror']['varpath'] ||= "$base_path/var"

node['apt-mirror']['arch'] ||= "amd64"
node['apt-mirror']['threads'] ||= "20"

node['apt-mirror']['hour'] ||= "1"
node['apt-mirror']['minute'] ||= "18"

template "/etc/apt/mirror.list" do
  source "mirror.list.erb"
  variables ({
    :base_path => node['apt-mirror']['basepath'],
    :mirror_path => node['apt-mirror']['mirrorpath'],
    :skel_path => node['apt-mirror']['skelpath'],
    :var_path => node['apt-mirror']['varpath'],
    :defaultarch => node['apt-mirror']['arch'],
    :threads => node['apt-mirror']['threads'],
    :sources => node['apt-mirror']['sources']
  })
end

cron "apt-mirror" do
  user "apt-mirror"
  hour "#{node['apt-mirror']['hour']}"
  minute "#{node['apt-mirror']['minute']}"
  command "/usr/bin/apt-mirror > /var/spool/apt-mirror/var/cron.log"
end
