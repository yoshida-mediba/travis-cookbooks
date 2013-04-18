#
# Cookbook Name:: travis_build_environment
# Recipe:: osx
# Copyright 2011-2013, Travis CI Development Team <contact@travis-ci.org>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

execute "update permissions on /usr/local" do
  command "chown -R travis:admin /usr/local"
  user "root"
end

cookbook_file "/usr/bin/travis-startup-script" do
  owner "root"
  group "wheel"
  mode 0755

  source "bin/travis-startup-script"
end

cookbook_file "/etc/profile" do
  owner "root"
  group "wheel"
  mode 0644

  source "etc/profile-osx"
end

cookbook_file "/etc/rc.common" do
  owner "root"
  group "wheel"
  mode 0644

  source "etc/rc.common-osx"
end

directory "/etc/profile.d" do
  owner "root"
  group "wheel"
  mode "0755"
  action :create
end

template "/etc/launchd.conf" do
  owner "root"
  group "wheel"
  mode 0644

  source "etc/launchd.conf.erb"
end

include_recipe "travis_build_environment::ci_user"
