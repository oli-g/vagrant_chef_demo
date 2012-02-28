set :user, "vagrant"

role :web, "vagrantbox"
role :app, "vagrantbox"
role :db,  "vagrantbox", :primary => true

set :rails_env, "staging"
