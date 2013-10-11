require './lib/phonetic/soundex'

include Phonetic

describe Soundex do
  describe '.encode' do
    it 'should return soundex code of word' do
      Soundex.encode('Ackerman').should == 'A265'
      Soundex.encode('Fusedale').should == 'F234'
      Soundex.encode('Grahl').should == 'G640'
      Soundex.encode('Hatchard').should == 'H326'
      Soundex.encode('implementation').should == 'I514'
      Soundex.encode('Prewett').should == 'P630'
    end

    it 'should add zeros if result less then 4 symbols' do
      Soundex.encode('ammonium').should == 'A500'
      Soundex.encode('Rubin').should == 'R150'
      Soundex.encode('H').should == 'H000'
    end

    it 'should return empty string for empty word' do
      Soundex.encode('').should == ''
    end
  end
end