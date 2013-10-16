require 'phonetic'

describe String do
  describe '#double_metaphone' do
    it 'should return Double Metaphone code of string' do
      'Gelatin'.double_metaphone.should == ['KLTN', 'JLTN']
    end
  end

  describe '#metaphone2' do
    it 'should return Double Metaphone code of string' do
      'whirlpool'.metaphone2.should == ['ARLP', 'ARLP']
    end
  end
end
