require 'spec_helper'

describe String do
  describe '#soundex' do
    it 'should return soundex code of word' do
      'Ackerman'.soundex.should == 'A265'
      'Fusedale'.soundex.should == 'F234'
      'Grahl'.soundex.should == 'G640'
      'Hatchard'.soundex.should == 'H326'
      'implementation'.soundex.should == 'I514'
      'Prewett'.soundex.should == 'P630'
    end

    it 'should add zeros if result less then 4 symbols' do
      'ammonium'.soundex.should == 'A500'
      'Rubin'.soundex.should == 'R150'
      'H'.soundex.should == 'H000'
    end

    it 'should return empty string for empty word' do
      ''.soundex.should == ''
    end
  end
end
