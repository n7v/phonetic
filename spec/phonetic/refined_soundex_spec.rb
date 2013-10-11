require 'spec_helper'

describe Phonetic::RefinedSoundex do
  describe '.encode' do
    it 'should return refined soundex code of word' do
      Phonetic::RefinedSoundex.encode('Braz').should == 'B1905'
      Phonetic::RefinedSoundex.encode('Caren').should == 'C30908'
      Phonetic::RefinedSoundex.encode('Hayers').should == 'H093'
      Phonetic::RefinedSoundex.encode('Lambard').should == 'L7081096'
      Phonetic::RefinedSoundex.encode('Noulton').should == 'N807608'
    end
  end
end
