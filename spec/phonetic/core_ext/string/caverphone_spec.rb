require 'spec_helper'

describe String do
  describe '#caverphone' do
    it 'should return Caverphone value of string' do
      'Lashaunda'.caverphone.should == 'LSNT11'
    end
  end
end
