require 'spec_helper'

describe 'mcelog', :type => :class do

  describe 'for osfamily RedHat' do
    let(:facts) {{ :osfamily => 'RedHat' }}

    it { should contain_package('mcelog').with_ensure('present') }
    it do
      should contain_file('/etc/mcelog/mcelog.conf').with({
        :ensure => 'file',
        :owner  => 'root',
        :group  => 'root',
        :mode   => '0644',
      })
    end
    it do
      should contain_service('mcelogd').with({
        :ensure     => 'running',
        :hasstatus  => true,
        :hasrestart => true,
        :enable     => true,
      })
    end
  end

end
