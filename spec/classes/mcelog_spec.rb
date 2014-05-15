require 'spec_helper'

describe 'mcelog', :type => :class do

  context 'osfamily RedHat' do
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
      should contain_service('mcelog').with({
        :ensure     => 'running',
        :name       => 'mcelogd',
        :hasstatus  => true,
        :hasrestart => true,
        :enable     => true,
      })
    end
  end # osfamily RedHat

  context 'unsupported osfamily' do
    let :facts do
      {
        :osfamily        => 'Solaris',
        :operatingsystem => 'Solaris',
      }
    end

    it 'should fail' do
      expect { should contain_class('sysstat::params') }.
        to raise_error(Puppet::Error, /not supported on Solaris/)
    end
  end # unsupported osfamily
end
