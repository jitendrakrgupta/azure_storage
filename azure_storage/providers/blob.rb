def whyrun_supported?
  true
end

def load_current_resource
  @device = new_resource.device
  @fstype = new_resource.fstype
  @mountpoint = new_resource.mountpoint
  @user = new_resource.user
  @group = new_resource.group
  @mode = new_resource.mode
end

action :attach_volume do
  if attached_to_vm? && !is_mounted? && !fs_exists?
    if create_fs? && create_mountpoint? && mount_fs?
      add_fstab_entry
      true
    end
  end
end

def attached_to_vm?
  puts "\nDevice to be verified for attachment = #{@device}"
  device_attach_status = `sudo lsblk #{@device}`
  if $?.exitstatus == 0
    puts "Device #{@device} found on this VM"
    true
  else
    puts "ERROR - Device #{@device} not found on this VM"
    false
  end
end

def is_mounted?
  puts "Device to be verified for mount = #{@device}"
  begin
    if ::File.readlines('/proc/mounts').any? {|line| line.split(" ")[0].downcase.include? "#{@device}".downcase}
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
  puts "Checking if filesystem exists on #{@device}... "
  device_fs = `sudo file -s #{@device}|awk '{ print $2}'`.chomp
  if device_fs != "data"
    puts "ERROR - Device #{@device} already has filesystem or does not exist ...Quiting"
    true
  else
    puts "Device #{@device} has no filesystem."
    false
  end
end

def create_mountpoint?
  if Dir.exists?("#{@mountpoint}")
    puts "ERROR - mountpoint #{@mountpoint} already exists"
    false
  else
    begin
      if Dir.mkdir("#{@mountpoint}")
        puts "mountpoint #{@mountpoint} created successfully"
        true
      end
    rescue Exception => e
      puts "ERROR - mountpoint #{@mountpoint} creation failed - #{e.message}"
      false
    end
  end
end

def create_fs?
  puts "File system #{@fstype} to be created on #{@device}"
  mkfs_stdout = `sudo mkfs -t #{@fstype} #{@device}`
  if $?.exitstatus == 0
    puts "File system #{@fstype} created successfully on #{@device}"
    puts mkfs_stdout
    true
  else
    puts "ERROR - File system #{@fstype} creation failed on #{@device}"
    puts mkfs_stdout
    false
  end
end

def mount_fs?
  puts "Device #{@device} to be mounted on #{@mountpoint}"
  mount_stdout = `sudo mount #{@device} #{@mountpoint}`
  if $?.exitstatus == 0
    puts "Device #{@device} mounted successfully on #{@mountpoint}"
    true
  else
    puts "ERROR - Device #{@device} failed to be mounted on #{@mountpoint}"
    puts mount_stdout
  end
end

def add_fstab_entry
  mount "#{new_resource.mountpoint}" do
    device "#{new_resource.device}"
    fstype "#{new_resource.fstype}"
    action :enable
  end
end
