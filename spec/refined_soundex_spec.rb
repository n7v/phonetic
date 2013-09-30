require './lib/refined_soundex'

include Phonetic

describe RefinedSoundex do
  describe '.code' do
    it "should return refined soundex code of word" do
      RefinedSoundex.code('Braz').should == 'B1905'
      RefinedSoundex.code('Caren').should == 'C30908'
      RefinedSoundex.code('Hayers').should == 'H093'
      RefinedSoundex.code('Lambard').should == 'L7081096'
      RefinedSoundex.code('Noulton').should == 'N807608'
    end
  end
end