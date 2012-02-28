name "web"
description "Install web stack with Rbenv, Nginx and Passenger, and Redis key-value store"
run_list(
  "recipe[ruby_build]",
  "recipe[rbenv::system]",
  "recipe[nginx::source]",
  "recipe[rbenv_passenger::nginx]",
  "recipe[iptables::web]"
  # "recipe[redis]"
)

# Attributes applied if the node doesn't have it set already.
default_attributes()

# Attributes applied no matter what the node has set already.
override_attributes()

# NGINX::SOURCE: https://gist.github.com/1221259
