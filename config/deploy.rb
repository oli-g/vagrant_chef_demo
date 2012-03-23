# Bundler bootstrap
require "bundler/capistrano"
set :default_environment, { "PATH" => "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH" }
set :bundle_flags, "--deployment --quiet --binstubs --shebang ruby-local-exec"

# Stages
require "capistrano/ext/multistage"
set :stages, %w(staging production)
set :default_stage, "staging"

default_run_options[:pty]   = true    # must be set for the password prompt from git to work
ssh_options[:forward_agent] = true    # use local keys instead of the ones on the server
on :start do 
  `ssh-add` 
end

set :use_sudo, true
set :group, "www-data"

set :application, "vagrant_chef_demo"
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache
set :normalize_asset_timestamps, false

# Repo details
set :scm, :git
set :scm_username, "oli-g"
set :repository, "git@github.com:oli-g/vagrant_chef_demo.git"
set :branch, "master"

after "deploy:setup", "deploy:fix_permissions"
after "bundle:install", "deploy:migrate"

namespace :deploy do  
  desc "Correct the permissions for the current directory"
  task :fix_permissions do
     sudo "chown -R #{user}:www-data #{deploy_to}"
  end
  
  desc "Restart Application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path, "tmp/restart.txt")}"
  end
end

namespace :nginx do
  desc "Restart Nginx"
  task :restart, :roles => :web, :except => { :no_release => true } do
    sudo "service nginx restart"
  end
end
