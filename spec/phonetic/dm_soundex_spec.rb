require 'spec_helper'
require 'support/dm_soundex_data'

describe Phonetic::DMSoundex do
  describe '.encode' do
    it 'should calculate Daitch-Mokotoff Soundex values of string' do
      Phonetic::DM_SOUNDEX_TEST_TABLE.each do |w, r|
        res =  Phonetic::DMSoundex.encode(w)
        res.should eq(r), "expected: #{r}\ngot: #{res}\nword: #{w}"
      end
    end
  end
end
