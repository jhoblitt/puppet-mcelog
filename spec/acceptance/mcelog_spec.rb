# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'mcelog class' do
  context 'with default params' do
    let(:manifest) do
      <<-PP
        class { 'mcelog': }
      PP
    end

    it_behaves_like 'an idempotent resource'

    describe package('mcelog') do
      it { is_expected.to be_installed }
    end

    describe service('mcelog') do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end

    describe file('/etc/mcelog/mcelog.conf') do
      it { is_expected.to be_file }
    end
  end
end
