name "database"
description "Install MySQL"
run_list(
  "recipe[mysql::server]"
  # "recipe[database::master]"
)

# Attributes applied if the node doesn't have it set already.
default_attributes()

# Attributes applied no matter what the node has set already.
override_attributes()

# https://gist.github.com/1105416 --------------> Chef mysql master/slave recipes
# https://github.com/engineyard/ey-cloud-recipes/tree/master/cookbooks/mysql_replication_check
# http://serverfault.com/questions/323623/how-do-i-use-chef-data-bags-to-setup-a-mysql-server
