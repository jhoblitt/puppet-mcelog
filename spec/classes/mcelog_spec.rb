require 'spec_helper'

describe 'mcelog', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it { should contain_package('mcelog').with_ensure('present') }
      it do
        should contain_file('mcelog.conf').with({
          :ensure  => 'file',
          :path    => '/etc/mcelog/mcelog.conf',
          :owner   => 'root',
          :group   => 'root',
          :mode    => '0644',
          :content => /^daemon = yes$/,
        })
      end

      it do
        is_expected.to contain_systemd__unit_file("mcelog.service").with(
          content: %r{StandardOutput=syslog},
        ).that_comes_before("Service[mcelog]")
        .that_requires("Package[mcelog]")
      end

      it do
        is_expected.to contain_service('mcelog').with(
          ensure: 'running',
          enable: true,
          name: 'mcelog',
        ).that_subscribes_to("File[mcelog.conf]")
      end

      context 'config_file_template =>' do
        context 'mcelog/mcelog.conf.erb' do
          let(:params) {{ :config_file_template => 'mcelog/mcelog.conf.erb' }}

          it do
            should contain_file('mcelog.conf').with({
              :ensure  => 'file',
              :path    => '/etc/mcelog/mcelog.conf',
              :owner   => 'root',
              :group   => 'root',
              :mode    => '0644',
              :content => /^daemon = yes$/,
            })
          end
        end # mcelog/mcelog.conf.erb
      end # config_file_template =>
    end
  end
end
