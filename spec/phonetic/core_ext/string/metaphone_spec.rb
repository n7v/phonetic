require 'phonetic'

describe String do
  describe '#metaphone' do
    it 'should return Metaphone code of string' do
      %w(Karen Carina Corin Crain Garneau Gorrono Krenn).each do |name|
        name.metaphone.should == 'KRN'
      end
    end
  end
end
