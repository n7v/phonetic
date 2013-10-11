require 'phonetic/refined_soundex'

include Phonetic

describe RefinedSoundex do
  describe '.encode' do
    it "should return refined soundex code of word" do
      RefinedSoundex.encode('Braz').should == 'B1905'
      RefinedSoundex.encode('Caren').should == 'C30908'
      RefinedSoundex.encode('Hayers').should == 'H093'
      RefinedSoundex.encode('Lambard').should == 'L7081096'
      RefinedSoundex.encode('Noulton').should == 'N807608'
    end
  end
end
