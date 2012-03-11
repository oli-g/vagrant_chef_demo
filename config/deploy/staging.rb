ssh_options[:keys] = `bundle exec vagrant ssh-config | grep IdentityFile | awk '{print $2}'`.chomp
ssh_options[:port] = 2222

set :user, "vagrant"

role :web, "localhost"
role :app, "localhost"
role :db,  "localhost", :primary => true

set :rails_env, "staging"
