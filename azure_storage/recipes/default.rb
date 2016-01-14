#
# Cookbook Name:: azure_storage
# Recipe:: default
#
# Copyright 2016, WalmartLabs
#
#

azure_storage_blob "disk1" do
  device '/dev/sdc'
  fstype 'ext4'
  mountpoint '/data1'
  user 'root'
  group 'root'
  mode '777'
  action :attach_volume
end
