== TODO

* Add another monitrc template to allow users to use 'monit' command.
* Use database cookbook for master creation.

== MODIFIED COOKBOOKS

* Monit: changed node[:host] to node[:hostname] in load template
* Nginx: fixed nginx::source recipe in order not to launch service before conf creation