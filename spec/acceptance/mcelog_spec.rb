# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'mcelog class' do
  package_name = 'mcelog'
  service_name = 'mcelogd'
  maj = fact_on 'master', 'operatingsystemmajrelease'

  describe 'running puppet code' do
    pp = <<-PP
      class { 'mcelog': }
    PP

    it 'applies the manifest twice with no stderr' do
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end

  describe package(package_name) do
    it { is_expected.to be_installed }
  end

  case maj.to_i
  when 5
    describe service(service_name) do
      it { is_expected.not_to be_running }
      it { is_expected.not_to be_enabled }
    end

    describe file('/etc/mcelog.conf') do
      it { is_expected.to be_file }
    end

    describe file('/etc/mcelog/mcelog.conf') do
      it { is_expected.not_to exist }
    end
  when 6
    describe service(service_name) do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled(3) }
    end

    describe file('/etc/mcelog.conf') do
      it { is_expected.not_to exist }
    end

    describe file('/etc/mcelog/mcelog.conf') do
      it { is_expected.to be_file }
    end
  end
end
