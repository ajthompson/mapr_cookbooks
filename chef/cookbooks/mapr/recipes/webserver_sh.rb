#
# Cookbook Name:: mapr
# Recipe:: webserver_sh
#
# This is necessary to for the webserver to allow login
#

include_recipe "java::oracle"

template "#{node[:mapr][:home]}/conf/env.sh" do
  source "webserver.erb"
end