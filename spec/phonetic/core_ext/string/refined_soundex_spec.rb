require 'spec_helper'

describe String do
  describe '.refined_soundex' do
    it 'should return refined soundex code of word' do
      'Braz'.refined_soundex.should == 'B1905'
      'Caren'.refined_soundex.should == 'C30908'
      'Hayers'.refined_soundex.should == 'H093'
      'Lambard'.refined_soundex.should == 'L7081096'
      'Noulton'.refined_soundex.should == 'N807608'
    end
  end
end
