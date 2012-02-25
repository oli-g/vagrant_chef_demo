maintainer       "Giannicola Olivadoti"
maintainer_email "olinicola@gmail.com"
license          "Apache 2.0"
description      "Installs and configures Passenger under Rbenv with Apache or Nginx"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

recipe "rbenv_passenger",           "Installs Passenger gem with Rbenv"
recipe "rbenv_passenger::apache2",  "Enables Apache module configuration for Passenger under Rbenv"
recipe "rbenv_passenger::nginx",    "Enables Nginx module configuration for Passenger under Rbenv"

depends "rbenv",    "~> 0.6.1"
depends "nginx",    "~> 0.99.0"
depends "apache2",  "~> 0.99.4"

%w{ ubuntu debian suse }.each do |os|
  supports os
end
