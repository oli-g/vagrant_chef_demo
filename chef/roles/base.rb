name "base"
description "Base role applied to all nodes."
run_list(
  "recipe[apt]",
  "recipe[users::sysadmins]",
  "recipe[sudo]",
  "recipe[build-essential]",
  "recipe[openssh]",
  "recipe[iptables]",
  "recipe[iptables::ssh]",
  "recipe[iptables::boot]",
  # "recipe[zsh]",
  "recipe[ntp]",
  "recipe[vim]",
  "recipe[git]",
  # "recipe[ssh_known_hosts]",
  "recipe[screen]",
  "recipe[hostname]",
  "recipe[monit]",
  "recipe[fail2ban]"
  # "recipe[logrotate]"
)

# Attributes applied if the node doesn't have it set already.
default_attributes()

# Attributes applied no matter what the node has set already.
override_attributes()
