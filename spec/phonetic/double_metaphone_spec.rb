require 'spec_helper'
require 'support/double_metaphone_data'

describe Phonetic::DoubleMetaphone do
  describe '.encode' do
    it 'should return Double Metaphone codes of string' do
      Phonetic::DOUBLE_METAPHONE_TEST_TABLE.each do |w, r|
        Phonetic::DoubleMetaphone.encode(w).should == r
      end
    end
  end
end
