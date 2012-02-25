name "database"
description "Install MySQL"
run_list(
  "recipe[mysql::server]" #,
  # "recipe[database::master]"
)
# default_attributes()
# https://gist.github.com/1105416 --------------> Chef mysql master/slave recipes
# http://serverfault.com/questions/323623/how-do-i-use-chef-data-bags-to-setup-a-mysql-server