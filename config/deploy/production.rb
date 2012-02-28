set :user, "deploy"

role :web, "192.168.211.240"                     # Your HTTP server, Apache/etc
role :app, "192.168.211.240"                     # This may be the same as your `Web` server
role :db,  "192.168.211.240", :primary => true   # This is where Rails migrations will run
