#
# Cookbook Name:: mapr
# Recipe:: disable_services
#
# Copyright 2013, MapR Technologies
#

# disable zookeeper and warden services
service "mapr-zookeeper" do
  action :disable
  only_if {File.exists?("/etc/init.d/mapr-zookeeper")}
end

service "mapr-warden" do
  action :disable
end

service "mapr-hive" do
	action :disable
	only_if {File.exists?("/etc/init.d/mapr-hive")}
end

service "mapr-hiveserver2" do
	action :disable
	only_if {File.exists?("/etc/init.d/mapr-hiveserver2")}
end

service "mapr-hivemetastore" do
	action :disable
	only_if {File.exists?("/etc/init.d/mapr-hivemetastore")}
end
