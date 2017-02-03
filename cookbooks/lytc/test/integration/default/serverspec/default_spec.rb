describe package('htop') do
  it { should be_installed }
end

describe command('vim --version') do
  its(:exit_status) { should eq 0 }
end

describe file('/root/.vimrc') do
  it { should be_file }
  it { should exist }
  its(:content) { should match /syntax on/ }
end
