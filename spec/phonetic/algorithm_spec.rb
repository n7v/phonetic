require './lib/phonetic/algorithm'

include Phonetic

describe Algorithm do
  describe '.encode_word' do
    it 'should return not modified word' do
      Algorithm.encode_word('cat').should == 'cat'
    end
  end

  describe '.encode' do
    it 'should return list of words without extra spaces' do
      Algorithm.encode('  cat  dog  ').should == 'cat dog'
    end
  end
end