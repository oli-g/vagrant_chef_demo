#
# Cookbook Name:: rbenv_passenger
# Recipe:: default
#
# Author:: Giannicola Olivadoti <olinicola@gmail.com>
#
# Copyright:: 2012, Giannicola Olivadoti
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

class Chef::Recipe
  include Chef::RbenvPassenger::RecipeHelpers
end

determine_rbenv_passenger_version_if_not_given
determine_rbenv_ruby_version_if_not_given

ruby_version      = node[:rbenv_passenger][:rbenv_ruby]
passenger_version = node[:rbenv_passenger][:version]

include_recipe "rbenv::system"

Array(node[:rbenv_passenger][:common_pkgs]).each do |pkg|
  package pkg
end

# Make sure that the specified Ruby version is installed through Rbenv
rbenv_ruby ruby_version

# Install Passenger gem for the specified Ruby version
rbenv_gem "passenger" do
  rbenv_version   ruby_version
  version         passenger_version
  action          :install
end

# Calculate the Passenger root path attribute. This is evaluated in the execute phase
# because the Rbenv environment is queried and the Ruby must be installed.
# rbenv_script "calculate_rbenv_passenger_root_path" do
#   rbenv_version   ruby_version
#   code            "passenger-config --root > /tmp/rbenv_passenger_root_path"
#   not_if          "test -f /tmp/rbenv_passenger_root_path"
# end
ruby_block "calculate_rbenv_passenger_root_path" do
  block do
    rbenv_root_path = node[:rbenv][:root_path]
    result = %x(/bin/bash -c 'RBENV_ROOT=#{rbenv_root_path} PATH=$RBENV_ROOT/bin:$PATH RBENV_VERSION=#{ruby_version} passenger-config --root').sub("\n", "")
    
    node.set[:rbenv_passenger][:passenger_root_path] = result
    Chef::Log.debug(%{Setting node[:rbenv_passenger][:passenger_root_path] = "#{node[:rbenv_passenger][:passenger_root_path]}"})
     
    ::File.open("/tmp/rbenv_passenger_root_path", "w") { |f| f.write result }
  end
  
  # INFO HERE: http://wiki.opscode.com/display/chef/Resources
  not_if  { node[:rbenv_passenger][:passenger_root_path] }
end


# Calculate the Ruby root path attribute if it isn't set. This is evaluated in the
# execute phase because the Rbenv environment is queried and the Ruby must be installed.
# rbenv_script "calculate_rbenv_ruby_root_path" do
#   rbenv_version   ruby_version
#   code            "rbenv which ruby > /tmp/rbenv_ruby_root_path"
#   not_if          "test -f /tmp/rbenv_ruby_root_path"
# end
ruby_block "calculate_rbenv_ruby_root_path" do
  block do
    rbenv_root_path = node[:rbenv][:root_path]
    result = %x(/bin/bash -c 'RBENV_ROOT=#{rbenv_root_path} PATH=$RBENV_ROOT/bin:$PATH RBENV_VERSION=#{ruby_version} rbenv which ruby').sub("\n", "")
    
    node.set[:rbenv_passenger][:ruby_root_path] = result
    Chef::Log.debug(%{Setting node[:rbenv_passenger][:ruby_root_path] = "#{node[:rbenv_passenger][:ruby_root_path]}"})
    
    ::File.open("/tmp/rbenv_ruby_root_path", "w") { |f| f.write result }
  end
  
  not_if  { node[:rbenv_passenger][:ruby_root_path] }
end
