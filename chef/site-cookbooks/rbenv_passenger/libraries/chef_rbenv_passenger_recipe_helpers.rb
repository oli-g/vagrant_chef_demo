#
# Cookbook Name:: rbenv_passenger
# Library:: Chef::RbenvPassenger::RecipeHelpers
#
# Author:: Giannicola Olivadoti <olinicola@gmail.com>
#
# Copyright 2012, Giannicola Olivadoti
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

class Chef
  module RbenvPassenger
    module RecipeHelpers
      ##
      # Sets the version attribute to the most current RubyGems release, unless set
      def determine_rbenv_passenger_version_if_not_given
        if node[:rbenv_passenger][:version].nil?
          require "rubygems"
          require "rubygems/dependency_installer"
          
          spec = Gem::DependencyInstaller.new.find_gems_with_sources(Gem::Dependency.new("passenger")).last[0]
          
          node.set[:rbenv_passenger][:version] = spec.version.to_s
          Chef::Log.debug(%{Setting node[:rbenv_passenger][:version] = } + %{"#{node[:rbenv_passenger][:version]}"})
        end
      end
      
      ##
      # Sets the rbenv_ruby attribute to rbenv global ruby, unless set
      def determine_rbenv_ruby_version_if_not_given
        if node[:rbenv_passenger][:rbenv_ruby].nil?
          ruby_version = node[:rbenv][:global]
          
          node.set[:rbenv_passenger][:rbenv_ruby] = ruby_version
          Chef::Log.debug(%{Setting node[:rbenv_passenger][:rbenv_ruby] = } + %{"#{node[:rbenv_passenger][:rbenv_ruby]}"})
        end
      end
    end
  end
end
