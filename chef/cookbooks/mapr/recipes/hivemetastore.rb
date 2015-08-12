#
# Cookbook Name:: mapr
# Recipe:: hivemetastore
#
# Copyright 2013, MapR Technologies
#
version = "v#{node['mapr']['version']}"
# Disable gpgcheck temporarily
if platform_family?("rhel")
  yum_repository "mapr_core" do
    url "#{node['mapr']['repo_url']}/#{version}/redhat"
    gpgkey "#{node['mapr']['repo_key_url']}"
    gpgcheck false
  end

  yum_repository "mapr_ecosystem" do
    url "#{node['mapr']['repo_url']}/ecosystem/redhat"
	gpgkey "#{node['mapr']['repo_key_url']}"
    gpgcheck false
  end
end

package "mapr-hive"

# Reenable the check
if platform_family?("rhel")
  yum_repository "mapr_core" do
    url "#{node['mapr']['repo_url']}/#{version}/redhat"
    gpgkey "#{node['mapr']['repo_key_url']}"
    gpgcheck true
  end

  yum_repository "mapr_ecosystem" do
    url "#{node['mapr']['repo_url']}/ecosystem/redhat"
	gpgkey "#{node['mapr']['repo_key_url']}"
    gpgcheck true
  end
end
