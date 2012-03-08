set :user, "deploy"

role :web, "192.168.211.240"
role :app, "192.168.211.240"
role :db,  "192.168.211.240", :primary => true

set :rails_env, "production"
