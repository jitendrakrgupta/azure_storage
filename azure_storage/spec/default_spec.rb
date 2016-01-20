require 'chefspec'

describe 'verify_fstab_file_existence' do
  let(:chef_run) { ChefSpec::ChefRunner.new.convergence('azure_storage_blob::default')}

  it { expect('/etc/fstab').to be_an_existing_file }
end
