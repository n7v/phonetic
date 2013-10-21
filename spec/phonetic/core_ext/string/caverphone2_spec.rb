require 'phonetic'

describe String do
  describe '#caverphone2' do
    it 'should return Caverphone 2 value of string' do
      'Deerdre'.caverphone2.should == 'TTA1111111'
    end
  end
end
