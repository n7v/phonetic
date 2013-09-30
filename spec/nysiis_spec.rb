require './lib/nysiis'

include Phonetic

describe NYSIIS do
  TABLE = {
    'Alexandra'     => 'ALAXANDR',
    'Aumont'        => 'AANAD',
    'Bonnie'        => 'BANY',
    'Christensen'   => 'CHRASTANSAN',
    'Cleveland'     => 'CLAFALAD',
    'Claudia'       => 'CLAD',
    'Dedee'         => 'DADY',
    'DeLaurentiis'  => 'DALARANT',
    'Echikunwoke'   => 'ECACANWAC',
    'Fahey'         => 'FAHY',
    'Jacqueline'    => 'JACGALAN',
    'John'          => 'J',
    'Hessel'        => 'HASAL',
    'Hubert'        => 'HABAD',
    'Howard'        => 'HAD',
    'Knuth'         => 'NNAT',
    'Kepler'        => 'CAPLAR',
    'Marguerite'    => 'MARGARAT',
    'Smith'         => 'SNAT',
    'Schelte'       => 'SSALT',
    'Macdonald'     => 'MCDANALD',
    'Michael'       => 'MACAL',
    'Phoenix'       => 'FFANAX',
    'Pfeiffer'      => 'FFAFAR',
    'Rebecca'       => 'RABAC',
    'Rosalind'      => 'RASALAD',
    'Schmidt'       => 'SSNAD'
  }

  describe '.code' do
    it 'should return NYSIIS code of word' do
      TABLE.each do |word, result|
        NYSIIS.code(word, trim: false).should == result
      end
    end

    it 'should return empty string for empty word' do
      NYSIIS.code('').should == ''
    end

    it 'should ignore non-english symbols in input' do
      NYSIIS.code('1234567890+-= Bess $').should == 'BAS'
    end
  end
end