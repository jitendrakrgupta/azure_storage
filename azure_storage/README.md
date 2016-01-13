azure_storage Cookbook
======================
This Cookbook does the following on the local VM :-
  1. Verifies that the storage device provided is indeed present on the VM.
  2. The device is neither mounted nor in use by the VM.
  3. Creates filesystem(ext4) by default on the new device.
  4. Mounts it on the specified mountpoint.

Requirements
------------
1. This is for a CentOS VM.
2. The VM should be up and running.
3. The new storage device is already created in Azure Storage and is attached to the VM.

#### packages
- `Dir` - azure_storage needs this ruby gem.

Attributes
----------
- "device": eg. /dev/sdc
- "fstype": eg. "ext4"
- "mountpoint": eg. "/mnt",
- "user": eg. "root",
- "group": eg. "root",
- "mode": eg. "777"

Usage
-----
#### azure_storage::default
```ruby
azure_storage_blob "disk1" do
  "device": "/dev/sdc",
  "fstype": "ext4",
  "mountpoint": "/data1",
  "user": "root",
  "group": "root",
  "mode": "777"
end
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: WalmartLabs
