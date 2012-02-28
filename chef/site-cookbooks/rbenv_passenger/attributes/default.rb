#
# Cookbook Name:: rbenv_passenger
# Attributes:: default
#
# Author:: Giannicola Olivadoti (<olinicola@gmail.com>)
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
#

# version will default to most current version from RubyGems, unless overriden
default[:rbenv_passenger][:version] = nil

# rbenv_ruby will default to "#{node[:rbenv][:global]}", unless overriden
default[:rbenv_passenger][:rbenv_ruby] = nil

default[:rbenv_passenger][:passenger_user] = "www-data"
default[:rbenv_passenger][:passenger_group] = "www-data"
# default[:rbenv_passenger][:max_pool_size] = 10
# default[:passenger][:conf][:max_requests] = 1000
# default[:rbenv_passenger][:min_instances] = 2
# default[:passenger][:production][:pool_idle_time] = 0
# default[:passenger][:production][:max_instances_per_app] = 0
# default[:passenger][:production][:sendfile] = true
# default[:passenger][:production][:tcp_nopush] = false
# default[:passenger][:production][:keepalive_timeout] = 65
# default[:passenger][:production][:gzip] = true
# default[:passenger][:production][:worker_connections] = 1024

case platform
when "suse"
  node.set[:rbenv_passenger][:common_pkgs]  = %w{libcurl-devel}
  node.set[:rbenv_passenger][:apache2_pkgs] = %w{apache2-devel libapr1-devel libapr-util1-devel}
else
  node.set[:rbenv_passenger][:common_pkgs]  = %w{libcurl4-openssl-dev } # libpcre3-dev
  node.set[:rbenv_passenger][:apache2_pkgs] = %w{apache2-threaded-dev libapr1-dev libaprutil1-dev}
end
