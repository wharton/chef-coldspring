#
# Cookbook Name:: coldspring
# Recipe:: coldspring
#
# Copyright 2012, Courtney Wilburn
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
#

# Install the unzip package

package "unzip" do
  action :install
end

node.set['coldspring']['owner'] = "nobody" if node['coldspring']['owner'] == nil

file_name = node['coldspring']['download']['url'].split('/').last

# Download coldspring

remote_file "#{Chef::Config['file_cache_path']}/#{file_name}" do
  source "#{node['coldspring']['download']['url']}"
  action :create_if_missing
  mode "0744"
  owner "root"
  group "root"
  not_if { File.directory?("#{node['coldspring']['install_path']}/coldspring") }
end

# Create Directory if missing

directory "#{node['coldspring']['install_path']}" do
 owner node['coldspring']['owner']
 group node['coldspring']['group']
 mode "0755"
 recursive true
 action :create
 not_if { File.directory?("#{node['coldspring']['install_path']}") }
end

# Extract archive

script "install_coldspring" do
  interpreter "bash"
  user "root"
  cwd "#{Chef::Config['file_cache_path']}"
  code <<-EOH
unzip #{file_name} -d coldspring 
mv coldspring #{node['coldspring']['install_path']}
chown -R #{node['coldspring']['owner']}:#{node['coldspring']['group']} #{node['coldspring']['install_path']}/coldspring
EOH
  not_if { File.directory?("#{node['coldspring']['install_path']}/coldspring") }
end

# Set up ColdFusion mapping

execute "start_cf_for_coldspring_default_cf_config" do
  command "/bin/true"
  notifies :start, "service[coldfusion]", :immediately
end

coldfusion902_config "extensions" do
  action :set
  property "mapping"
  args ({ "mapName" => "/coldspring",
          "mapPath" => "#{node['coldspring']['install_path']}/coldspring"})
end

