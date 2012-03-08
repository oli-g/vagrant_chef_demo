ssh_options[:keys] = `bundle exec vagrant ssh-config | grep IdentityFile | awk '{print $2}'`.chomp
ssh_options[:port] = 2222
puts ssh_options.inspect
set :user, "vagrant"

role :web, "127.0.0.1"
role :app, "127.0.0.1"
role :db,  "127.0.0.1", :primary => true

set :rails_env, "staging"
