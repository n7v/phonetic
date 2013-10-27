require 'phonetic'

describe String do
  describe '#dm_soundex' do
    it 'should return D-M Soundex code of string' do
      'Syjuco'.dm_soundex.should == ['450000', '445000', '440000', '444000']
    end
  end
end
