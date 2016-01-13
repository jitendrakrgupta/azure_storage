#
# Cookbook Name:: azure_storage
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

=begin

This Cookbook does the following on the local VM :-
  1. Verifies that the storage device provided is indeed present on the VM.
  2. The device is neither mounted nor in use by the VM.
  3. Creates filesystem(ext4) by default on the new device.
  4. Mounts it on the specified mountpoint.

azure_storage_blob "disk1" do
  "device": "/dev/sdc",
  "fstype": "ext4",
  "mountpoint": "/data1",
  "user": "root",
  "group": "root",
  "mode": "777"
end

=end
