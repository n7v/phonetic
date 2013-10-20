require 'phonetic/algorithm'

module Phonetic
  # Caverphone 2.0 created by the Caversham Project at the University of Otago.
  # @see http://caversham.otago.ac.nz/files/working/ctp150804.pdf Caverphone Revisited by David Hood
  # This class implements this algorithm.
  # @example
  #    Phonetic::Caverphone2.encode('Stevenson') # => 'STFNSN1111'
  #    Phonetic::Caverphone2.encode('Peter') # => 'PTA1111111'

  class Caverphone2 < Algorithm
    MAP = {
      /e$/ => '',
      /^(cou|rou|tou|enou|trou|)gh/ => '\12f',
      /^gn/ => '2n',
      /mb$/ => 'mb',
      'cq' => '2q',
      /c([iey])/ => 's\1',
      'tch' => '2ch',
      /[cqx]/ => 'k',
      'v' => 'f',
      'dg' => '2g',
      /ti([oa])/ => 'si\1',
      'd' => 't',
      'ph' => 'fh',
      'b' => 'p',
      'sh' => 's2',
      'z' => 's',
      /^[aeiou]/ => 'A',
      /[aeiou]/ => '3',
      'j' => 'y',
      /^y3/ => 'Y3',
      /^y/ => 'A',
      /y/ => '3',
      '3gh3' => '3kh3',
      'gh' => '22',
      'g' => 'k',
      /s+/ => 'S',
      /t+/ => 'T',
      /p+/ => 'P',
      /k+/ => 'K',
      /f+/ => 'F',
      /m+/ => 'M',
      /n+/ => 'N',
      'w3' => 'W3',
      'wh3' => 'Wh3',
      /w$/ => '3',
      'w' => '2',
      /^h/ => 'A',
      'h' => '2',
      'r3' => 'R3',
      /r$/ => '3',
      'r' => '2',
      'l3' => 'L3',
      /l$/ => '3',
      'l' => '2',
      '2' => '',
      /3$/ => 'A',
      '3' => ''
    }

    # Encode word to its Caverphone 2 code
    def self.encode_word(word, options = {})
      w = word.strip.downcase.gsub(/[^a-z]/, '')
      MAP.each { |r, v| w.gsub!(r, v) }
      w = w + '1' * 10
      w[0..9]
    end
  end
end
