require 'spec_helper'

describe 'mcelog', :type => :class do

  describe 'for osfamily RedHat' do
    it { should contain_class('mcelog') }
  end

end
