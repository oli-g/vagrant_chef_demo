# Searches data bag "users" for groups attribute "www-data".
# Places returned users in Unix group "www-data" with GID 33.
users_manage "www-data" do
  group_id 33
  action [ :remove, :create ]
end
