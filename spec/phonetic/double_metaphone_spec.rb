require 'spec_helper'
require 'support/double_metaphone_data'

describe Phonetic::DoubleMetaphone do
  describe '.encode' do
    it 'should return Double Metaphone codes of string' do
      Phonetic::DOUBLE_METAPHONE_TEST_TABLE.each do |w, r|
        Phonetic::DoubleMetaphone.encode(w).should == r
      end
    end

    it 'should support max size of the code option' do
      Phonetic::DoubleMetaphone.encode('accede', size: 3).should == ['AKS', 'AKS']
    end
  end
end
