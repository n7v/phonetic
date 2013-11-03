require 'spec_helper'
require 'support/caverphone_data'

describe Phonetic::Caverphone do
  describe '.encode' do
    it 'should return Caverphone value of string' do
      Phonetic::CAVERPHONE_TEST_TABLE.each do |word, code|
        res = Phonetic::Caverphone.encode(word)
        res.should eq(code), "expected: #{code}\ngot: #{res}\nword: #{word}"
      end
    end
  end
end
