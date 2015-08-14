#
# Cookbook Name:: mapr
# Recipe:: webserver_sh
#
# This is necessary to for the webserver to allow login
#

include_recipe "java::oracle"

template "#{node[:mapr][:home]}/adminuiapp/webserver" do
  source "webserver.erb"
end