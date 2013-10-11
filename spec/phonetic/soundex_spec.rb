require 'spec_helper'

describe Phonetic::Soundex do
  describe '.encode' do
    it 'should return soundex code of word' do
      Phonetic::Soundex.encode('Ackerman').should == 'A265'
      Phonetic::Soundex.encode('Fusedale').should == 'F234'
      Phonetic::Soundex.encode('Grahl').should == 'G640'
      Phonetic::Soundex.encode('Hatchard').should == 'H326'
      Phonetic::Soundex.encode('implementation').should == 'I514'
      Phonetic::Soundex.encode('Prewett').should == 'P630'
    end

    it 'should add zeros if result less then 4 symbols' do
      Phonetic::Soundex.encode('ammonium').should == 'A500'
      Phonetic::Soundex.encode('Rubin').should == 'R150'
      Phonetic::Soundex.encode('H').should == 'H000'
    end

    it 'should return empty string for empty word' do
      Phonetic::Soundex.encode('').should == ''
    end
  end
end
