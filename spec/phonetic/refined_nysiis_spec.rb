require 'spec_helper'
require 'support/refined_nysiis_data'

describe Phonetic::RefinedNYSIIS do
  describe '.encode' do
    it 'should return Refined NYSIIS code of word' do
      Phonetic::REFINED_NYSIIS_TEST_TABLE.each do |word, code|
        res = Phonetic::RefinedNYSIIS.encode(word, trim: false)
        res.should eq(code), "expected: #{code}\ngot: #{res}\nword: #{word}"
      end
    end

    it 'should return empty string for empty word' do
      Phonetic::RefinedNYSIIS.encode('').should == ''
    end

    it 'should remove roman numerals from the end of the string' do
      Phonetic::RefinedNYSIIS.encode('Alexander II', trim: false).should == 'ALAXANDAR'
    end

    it 'should remove "JR" "SR" from the end of the string' do
      Phonetic::RefinedNYSIIS.encode('Davis Jr').should == 'DAV'
      Phonetic::RefinedNYSIIS.encode('Davis Sr').should == 'DAV'
    end

    it 'should ignore non-english symbols in input' do
      Phonetic::RefinedNYSIIS.encode('1234567890+-= Bess $').should == 'B'
    end
  end
end
