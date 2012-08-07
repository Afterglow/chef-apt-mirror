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
  
basepath = node["apt-mirror"]["basepath"] || "/var/spool/apt-mirror"
mirrorpath = node["apt-mirror"]["mirrorpath"] || "$base_path/mirror"
skelpath = node["apt-mirror"]["skelpath"] || "$base_path/skel"
varpath = node["apt-mirror"]["varpath"] || "$base_path/var"

defaultarch = node["apt-mirror"]["arch"] || node[:kernel][:machine]
threads = node["apt-mirror"]["threads"] || "20"

sources = node["apt-mirror"]["sources"]

template "/etc/apt/mirror.list" do
  source "mirror.list.erb"
  variables ({
    :base_path => basepath,
    :mirror_path => mirrorpath,
    :skel_path => skelpath,
    :var_path => varpath,
    :defaultarch => defaultarch,
    :threads => threads,
    :sources => sources
  })
end
