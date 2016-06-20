#
# Cookbook Name:: riak
# Recipe:: default
#
# Copyright (C) 2016 Wang Zhijun
#
# All rights reserved - Do Not Redistribute
#
bash "install_riak_from_packagecloud" do
  code <<-EOH
  curl -s https://packagecloud.io/install/repositories/basho/riak/script.rpm.sh | sudo bash
  yum install riak-#{node['riak']['major_number']}.#{node['riak']['minor_number']}.#{node['riak']['incremental']}-#{node['riak']['build']}.el7.centos.x86_64 -y
  EOH
  not_if "which riak"
end

template "/etc/riak/riak.conf" do
  source "default/riak.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables({
    :ip => node["ipaddress"]
  })
end

template "/etc/riak/advanced.config" do
  source "default/advanced.config.erb"
  owner "root"
  group "root"
  mode "0644"
end

cookbook_file "/etc/security/limits.d/91-riak.conf" do
  source "default/91-riak.conf"
  owner "root"
  group "root"
  mode "0644"
end

