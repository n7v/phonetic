require 'spec_helper'
require 'support/double_metaphone_data'

describe Phonetic::DoubleMetaphone do
  describe '.encode' do
    it 'should return Double Metaphone codes of string' do
      Phonetic::DOUBLE_METAPHONE_TEST_TABLE.each do |w, code|
        res = Phonetic::DoubleMetaphone.encode(w)
        res.should eq(code), "expected: #{code}\ngot: #{res}\nword: #{w}"
      end
    end

    it 'should support max size of the code option' do
      Phonetic::DoubleMetaphone.encode('accede', size: 3).should == ['AKS', 'AKS']
    end
  end
end
