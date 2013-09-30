require './lib/soundex'

include Phonetic

describe Soundex do
  describe '.code' do
    it 'should return soundex code of word' do
      Soundex.code('Ackerman').should == 'A265'
      Soundex.code('Fusedale').should == 'F234'
      Soundex.code('Grahl').should == 'G640'
      Soundex.code('Hatchard').should == 'H326'
      Soundex.code('implementation').should == 'I514'
      Soundex.code('Prewett').should == 'P630'
    end

    it 'should add zeros if result less then 4 symbols' do
      Soundex.code('ammonium').should == 'A500'
      Soundex.code('Rubin').should == 'R150'
      Soundex.code('H').should == 'H000'
    end

    it 'should return empty string for empty word' do
      Soundex.code('').should == ''
    end
  end
end