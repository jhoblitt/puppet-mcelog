require 'spec_helper_acceptance'

describe 'mcelog class' do
  package_name = 'mcelog'
  service_name = 'mcelogd'
  maj = fact_on 'master', 'operatingsystemmajrelease'

  describe 'running puppet code' do
    pp = <<-EOS
      class { 'mcelog': }
    EOS

    it 'applies the manifest twice with no stderr' do
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end

  describe package(package_name) do
    it { should be_installed }
  end

  case maj.to_i
  when 5
    describe service(service_name) do
      it { should_not be_running }
      it { should_not be_enabled }
    end

    describe file('/etc/mcelog.conf') do
      it { should be_file }
    end

    describe file('/etc/mcelog/mcelog.conf') do
      it { should_not exist }
    end
  when 6
    describe service(service_name) do
      it { should be_running }
      it { should be_enabled(3) }
    end

    describe file('/etc/mcelog.conf') do
      it { should_not exist }
    end

    describe file('/etc/mcelog/mcelog.conf') do
      it { should be_file }
    end
  end
end
