# Description

Installs Passenger gem via Rbenv and configures Apache or Nginx.

# Requirements

## Chef

Tested on 0.10.4 but newer and older version should work
just fine. File an [issue][issues] if this isn't the case.

## Platform

The following platforms have been tested with this cookbook, meaning that
the recipes run on these platforms without error:

* ubuntu (10.04/10.10/11.04)
* debian (6.0)

Please [report][issues] any additional platforms so they can be added.

## Cookbooks

This cookbook depends on the following external cookbooks:

* [rbenv][rbenv_cb]
* [nginx][nginx_cb] (Opscode)
* [apache2][apache2_cb] (Opscode)

# Installation

Depending on the situation and use case there are several ways to install
this cookbook. All the methods listed below assume a tagged version release
is the target, but omit the tags to get the head of development. A valid
Chef repository structure like the [Opscode repo][chef_repo] is also assumed.

## From the Opscode Community Platform

**Coming soon:** To install this cookbook from the Opscode platform, use the *knife* command:

    knife cookbook site install rbenv_passenger

## Using Librarian

The [Librarian][librarian] gem aims to be Bundler for your Chef cookbooks.
Include a reference to the cookbook in a **Cheffile** and run
`librarian-chef install`. To install with Librarian:

    gem install librarian
    cd chef-repo
    librarian-chef init
    cat >> Cheffile <<END_OF_CHEFFILE
    cookbook 'rbenv_passenger',
      :git => 'git://github.com/oli-g/chef-rbenv_passenger.git', :ref => 'v0.0.1'
    END_OF_CHEFFILE
    librarian-chef install

## Using knife-github-cookbooks

The [knife-github-cookbooks][kgc] gem is a plugin for *knife* that supports
installing cookbooks directly from a GitHub repository. To install with the
plugin:

    gem install knife-github-cookbooks
    cd chef-repo
    knife cookbook github install oli-g/chef-rbenv_passenger/v0.8.0

## As a Git Submodule

A common practice (which is getting dated) is to add cookbooks as Git
submodules. This is accomplishes like so:

    cd chef-repo
    git submodule add git://github.com/oli-g/chef-rbenv_passenger.git cookbooks/rbenv_passenger
    git submodule init && git submodule update

**Note:** the head of development will be linked here, not a tagged release.

## As a Tarball

If the cookbook needs to downloaded temporarily just to be uploaded to a Chef
Server or Opscode Hosted Chef, then a tarball installation might fit the bill:

    cd chef-repo/cookbooks
    curl -Ls https://github.com/oli-g/chef-rbenv_passenger/tarball/v0.0.1 | tar xfz - && \
      mv oli-g-chef-rbenv_passenger-* rbenv_passenger

# Usage

Comming soon...

# Recipes

## default

Installs dependencies and contains helpers for other recipes.

## apache2

Installs Passenger as an Apache2 module. Requires the `apache2` recipe.

## nginx

Installs Passenger as an Nginx module. Requires the `nginx::source` recipe.

# Attributes

## version

The version of Passenger to deploy. This will be in a format used by the gem
command. For example:

    node['rbenv_passenger']['version'] = "3.0.8"

Default is the most current version which is queried dynamically from RubyGems.

## rbenv_ruby

The Rbenv Ruby under which to install the passenger gem.
For example:

    node['rbenv_passenger']['rbenv_ruby'] = "ruby-1.8.7-p352"

Default is the global Rbenv Ruby, i.e.
`"#{node['rbenv']['global']}"`.

## root_path

Optionally override the full path to the root of the installed Passenger gem.

## module_path

Optionallly override the full path to the Apache2 module.

# Resources and Providers

There are **no** resources or providers defined.

# Development

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make.

# License and Author

Author: Giannicola Olivadoti (<olinicola@gmail.com>)

Contributors: https://github.com/oli-g/chef-rbenv_passenger/contributors

Copyright: 2012, Giannicola Olivadoti

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[apache2_cb]:   http://community.opscode.com/cookbooks/apache2
[chef_repo]:    https://github.com/opscode/chef-repo
[kgc]:          https://github.com/websterclay/knife-github-cookbooks#readme
[librarian]:    https://github.com/applicationsonline/librarian#readme
[nginx_cb]:     http://community.opscode.com/cookbooks/nginx
[rbenv_cb]:     https://github.com/fnichol/chef-rbenv

[repo]:         https://github.com/oli-g/chef-rbenv_passenger
[issues]:       https://github.com/oli-g/chef-rbenv_passenger/issues
