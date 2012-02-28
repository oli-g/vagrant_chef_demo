# Bundler bootstrap
require "bundler/capistrano"
set :default_environment, { "PATH" => "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH" }
set :bundle_flags, "--deployment --quiet --binstubs --shebang ruby-local-exec"

# Stages
require "capistrano/ext/multistage"
set :stages, %w(staging production)
set :default_stage, "staging"

set :application, "vagrant_chef_demo"

# default_run_options[:pty]   = true  # must be set for the password prompt from git to work
ssh_options[:forward_agent] = true    # use local keys instead of the ones on the server
# on :start do 
#   `ssh-add` 
# end

set :deploy_to, "/var/www/vagrant_chef_demo"
set :deploy_via, :remote_cache
set :use_sudo, false

# Repo details
set :scm, :git
set :scm_username, "oli-g"
set :repository, "git@github.com:oli-g/vagrant_chef_demo.git"
set :branch, "master"

after "bundle:install", "deploy:migrate"

namespace :deploy do
  task :start do ; end
  task :stop  do ; end
  
  desc "Restart Application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path, "tmp/restart.txt")}"
  end
end
