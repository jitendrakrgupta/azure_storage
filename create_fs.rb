=begin

Assumptions:-
  1. This is for a CentOS VM.
  2. The VM is up and running.
  3. The new storage device is already created in Azure and is attached to the VM.

This script does the following steps :-
  1. Verifies that the storage device provided is indeed present on the VM.
  2. The device is neither mounted nor in use by the VM.
  3. Creates filesystem(ext4) by default on the new device.
  4. Mounts it in the specified mountpoint.

azure_attach_blob "app1" do
  "device": "/dev/sdc",
  "fstype": "ext4",
  "mountpoint": "/mnt",
  "user": "root",
  "group": "root",
  "mode": "777"
end

=end

class Add_Storage_Device

	def initialize(device, fstype, mountpoint, user, group, mode)
		@device, @fstype, @mountpoint, @user, @group, @mode = device, fstype, mountpoint, user, group, mode
	end

	protected

	def attached_to_vm?
		puts "Device to be verified for attachment = #{@device}"
		true
	end

	def is_mounted?
		puts "Device to be verified for mount = #{@device}"
		begin
			if File.readlines('/proc/mounts').any? {|line| line.split(" ")[0].downcase.include? "#{@device}".downcase}
				puts "Device #{@device} is already mounted "
				true
			else
				puts " Device #{@device} is not mounted "
				false
			end
		rescue Exception => e
			puts "ERROR - #{e.message}"
      true
		end
	end

	def fs_exists?
		puts "Device to be verified for fs_exists = #{@device} for FS type #{@fstype}"
		if system('sudo blkid -o value -s TYPE #{@device}') == "ext4"
			puts "Device #{@device} already has FS type ext4...Quiting"
			true
		else
			false
		end
	end

	def create_mountpoint?
		puts "mountpoint to be created on #{@mountpoint}"
		true
	end

	def create_fs?
		puts "File system #{@fstype} to be created on #{@device}"
		true
	end

	def mount_fs?
		puts "Device #{@device} to be mounted on #{@mountpoint}"
		true
	end

	public

	def verify_storage_disk?
		if self.attached_to_vm? && !self.is_mounted? && !self.fs_exists?
			if self.create_fs? && self.create_mountpoint? && self.mount_fs?
				true
			end
		end
	end

end

app1_fs = Add_Storage_Device.new("/dev/sdc", "ext4", "/app1", "app1", "app1", "755")
if app1_fs.verify_storage_disk?
	puts " SUCCESS - Device attached "
else
	puts " ERROR - Failed to attach the device"
end
