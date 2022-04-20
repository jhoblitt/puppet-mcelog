# frozen_string_literal: true

require 'spec_helper'

describe 'mcelog', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with default params' do
        it { is_expected.to contain_package('mcelog') }
        it { is_expected.not_to contain_file('mcelog.conf') }

        it do
          is_expected.to contain_service('mcelog').with(
            ensure: 'running',
            enable: true,
            name: 'mcelog',
          ).that_requires('Package[mcelog]')
        end
      end

      context 'with service disabled' do
        let(:params) do
          {
            service_ensure: 'stopped',
            service_enable: false,
          }
        end

        it { is_expected.to contain_package('mcelog') }
        it { is_expected.not_to contain_file('mcelog.conf') }

        it do
          is_expected.to contain_service('mcelog').with(
            ensure: 'stopped',
            enable: false,
            name: 'mcelog',
          ).that_requires('Package[mcelog]')
        end
      end

      context 'with config_file_content param' do
        let(:params) do
          {
            config_file_content: 'foo',
          }
        end

        it { is_expected.to contain_package('mcelog') }

        it do
          is_expected.to contain_file('mcelog.conf').with(
            ensure: 'file',
            path: '/etc/mcelog/mcelog.conf',
            owner: 'root',
            group: 'root',
            mode: '0644',
            content: %r{^foo$},
          ).that_requires('Package[mcelog]').that_notifies('Service[mcelog]')
        end
      end
    end
  end
end
