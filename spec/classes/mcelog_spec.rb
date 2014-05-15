require 'spec_helper'

describe 'mcelog', :type => :class do

  context 'osfamily RedHat' do
    let(:facts) {{
      :architecture => 'x86_64',
      :osfamily     => 'RedHat',
    }}

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

  context 'unsupported architecture' do
    let :facts do
      {
        :architecture => 'i386',
        :osfamily     => 'RedHat',
      }
    end

    it 'should fail' do
      expect { should contain_class('mcelog::params') }.
        to raise_error(Puppet::Error, /not supported on architecture: i386/)
    end
  end # unsupported architecture

  context 'unsupported osfamily' do
    let :facts do
      {
        :architecture => 'x86_64',
        :osfamily     => 'Solaris',
      }
    end

    it 'should fail' do
      expect { should contain_class('mcelog::params') }.
        to raise_error(Puppet::Error, /not supported on osfamily: Solaris/)
    end
  end # unsupported osfamily
end
