Assumptions:-
  1. This is for a CentOS vm.
  2. The VM is up and running.
  3. The new storage device is already created in Azure and is attached to the VM.

This script does the following steps :-
  1. Verifies that the storage device provided is indeed present on the VM.
  2. The device is neither mounted nor in use by the VM.
  3. Creates filesystem(ext4) by default on the new device.
  4. Mounts it in the specified mountpoint.

Jgupta4StorageTestVM1-20151222-115611.vhd

class add_storage_device
  attr_accessor :device, :fstype, :mountpoint, :user, :group, :mode

  def initialize(device, fstype, mountpoint, user, group, mode)
    @device, @fstype, @mountpoint, @user, @group, @mode = device, fstype, mountpoint, user, group, mode
  end


end

            "device": "/dev/sdc",
            "fstype": "ext4",
            "mountpoint": "/mnt",
            "user": "root",
            "group": "root",
            "mode": "777"

if device_attached_to_vm("#{device}")
  if device_not_mounted("#{device}")
    if fs_exists("#{device}")
      create_fs("#{device}")
      mount_fs("#{device}")
    else
      puts "ERROR -  Filesystem already exists on Storage device #{device}"
    end
  else
    puts "Error - Storage device #{device} is currently mounted and in use."
  end
else
  puts "ERROR - Storage device #{device} is not attached to VM."
end
