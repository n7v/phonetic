require 'phonetic/algorithm'

module Phonetic
  # Caverphone created by the Caversham Project at the University of Otago.
  # @see http://caversham.otago.ac.nz/files/working/ctp060902.pdf Caverphone: Phonetic Matching algorithm by David Hood (2002)
  # This class implements this algorithm.
  # @example
  #    Phonetic::Caverphone.encode('Charmain') # => 'KMN111'
  #    Phonetic::Caverphone.encode('Ellett')   # => 'ALT111'
  #    Phonetic::Caverphone.encode('Siegmund') # => 'SKMNT1'
  class Caverphone < Algorithm
    MAP = {
      /^(cou|rou|tou|enou)gh/ => '\12f',
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
      /wy/ => 'Wy',
      'wh3' => 'Wh3',
      'why' => 'Why',
      'w' => '2',
      /^h/ => 'A',
      'h' => '2',
      'r3' => 'R3',
      'ry' => 'Ry',
      'r' => '2',
      'l3' => 'L3',
      'ly' => 'Ly',
      'l' => '2',
      'j' => 'y',
      'y3' => 'Y3',
      'y' => '2',
      '2' => '',
      '3' => ''
    }

    # Encode word to its Caverphone code
    def self.encode_word(word, options = {})
      w = word.strip.downcase.gsub(/[^a-z]/, '')
      MAP.each { |r, v| w.gsub!(r, v) }
      w = w + '1' * 6
      w[0..5]
    end
  end
end
