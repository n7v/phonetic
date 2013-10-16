require 'spec_helper'

describe Phonetic::Metaphone2 do
  describe '.encode' do
    it 'should return Double Metaphone codes of string' do
      Phonetic::Metaphone2.encode('biaggi').should == ['PJ', 'PK']
    end
  end
end
