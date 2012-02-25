#
# Cookbook Name:: rbenv_passenger
# Based on rvm_passenger
# Recipe:: default
#
# Author:: Fletcher Nichol <fnichol@nichol.ca>
#
# Copyright:: 2010, 2011, Fletcher Nichol
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
  # mix in recipe helpers
  include Chef::RbenvPassenger::RecipeHelpers
end

determine_rbenv_passenger_version_if_not_given
determine_rbenv_ruby_version_if_not_given

ruby_version      = node['rbenv_passenger']['rbenv_ruby']
passenger_version = node['rbenv_passenger']['version']

include_recipe "rbenv::system"

Array(node['rbenv_passenger']['common_pkgs']).each do |pkg|
  package pkg
end

# make sure that the specified ruby version is installed through Rbenv
rbenv_ruby ruby_version

rbenv_gem "passenger" do
  action          :install
  rbenv_version   ruby_version
  version         passenger_version
end

# calculate the root_path attribute. This is evaluated in the
# execute phase because the Rbenv environment is queried and the Ruby must be
# installed.
rbenv_script "Calculate Rbenv Passenger root path" do
  rbenv_version   ruby_version
  code            "passenger-config --root > /tmp/rbenv_passenger_root_path"
  
  not_if          "test -f /tmp/rbenv_passenger_root_path"
end

# calculate the ruby_wrapper attribute if it isn't set. This is evaluated in
# the execute phase because the RVM environment is queried and the Ruby must be
# installed.
rbenv_script "Calculate Rbenv Ruby root path" do
  rbenv_version   ruby_version
  code            "rbenv which ruby > /tmp/rbenv_ruby_root_path"
  
  not_if          "test -f /tmp/rbenv_ruby_root_path"
end
