require 'spec_helper'

describe String do
  describe '#refined_soundex' do
    it 'should return refined soundex code of word' do
      'Braz Caren Hayers'.refined_soundex.should == 'B1905 C30908 H093'
      'Lambard Noulton'.refined_soundex.should == 'L7081096 N807608'
    end
  end
end
