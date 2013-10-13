require 'spec_helper'
require 'support/nysiis_data'

describe String do
  describe '#nysiis' do
    it 'should return NYSIIS code of word' do
      Phonetic::NYSIIS_TEST_TABLE.each do |word, result|
        word.nysiis(trim: false).should == result
      end
    end
  end
end
