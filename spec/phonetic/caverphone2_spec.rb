require 'spec_helper'
require 'support/caverphone2_data'

describe Phonetic::Caverphone2 do
  describe '.encode' do
    it 'should return Caverphone 2 value of string' do
      Phonetic::CAVERPHONE2_TEST_TABLE.each do |code, words|
        words.each do |word|
          res = Phonetic::Caverphone2.encode(word)
          res.should eq(code), "expected: #{code}\ngot: #{res}\nword: #{word}"
        end
      end
    end
  end
end
