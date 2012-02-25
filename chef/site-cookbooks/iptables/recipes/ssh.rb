# Have we decided to lock down the node?
if node[:iptables][:ssh][:addresses].empty?
  iptables_rule "all_ssh"
  iptables_rule "network_ssh", :enable => false
else
  iptables_rule "network_ssh"
  iptables_rule "all_ssh", :enable => false
end
