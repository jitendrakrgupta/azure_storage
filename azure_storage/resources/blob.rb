actions :attach_volume

attribute :device, kind_of: String, required: true
attribute :fstype, kind_of: String, default: 'ext4'
attribute :mountpoint, kind_of: String, required: true
attribute :user, kind_of: String, default: 'root'
attribute :group, kind_of: String, default: 'root'
attribute :mode, kind_of: String, default: '777'
