name "web"
description "Install web stack with Rbenv, Nginx and Passenger, and Redis key-value store"
run_list(
  "recipe[ruby_build]",
  "recipe[rbenv::system]",
  "recipe[rbenv_passenger::nginx]",
  "recipe[iptables::web]",
  "recipe[logrotate]" #,
  # "recipe[redis]"
)
# default_attributes()
