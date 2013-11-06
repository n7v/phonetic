require 'spec_helper'

describe String do
  describe '#refined_nysiis' do
    it 'should return Refined NYSIIS code of word' do
      'Schmidt'.refined_nysiis.should == 'SNAD'
    end
  end
end
