require 'spec_helper'
require 'support/nysiis_data'

describe Phonetic::NYSIIS do
  describe '.encode' do
    it 'should return NYSIIS code of word' do
      Phonetic::NYSIIS_TEST_TABLE.each do |word, result|
        Phonetic::NYSIIS.encode(word, trim: false).should == result
      end
    end

    it 'should return empty string for empty word' do
      Phonetic::NYSIIS.encode('').should == ''
    end

    it 'should ignore non-english symbols in input' do
      Phonetic::NYSIIS.encode('1234567890+-= Bess $').should == 'BAS'
    end
  end
end
