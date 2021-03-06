require 'phonetic/algorithm'

module Phonetic
  # This class implements original version of NYSIIS algorithm.
  # @example
  #    Phonetic::NYSIIS.encode('Alexandra') # => 'ALAXANDR'
  #    Phonetic::NYSIIS.encode('Aumont') # => 'AANAD'
  #    Phonetic::NYSIIS.encode('Bonnie') # => 'BANY'
  class NYSIIS < Algorithm
    FIRST_CHAR_TABLE = {
      /^MAC/ => 'MCC',
      /^KN/ => 'NN',
      /^K/ => 'C',
      /^(PH|PF)/ => 'FF',
      /^SCH/ => 'SSS'
    }

    LAST_CHAR_TABLE = {
      /(EE|IE)$/ => 'Y',
      /(DT|RT|RD|NT|ND)$/ => 'D'
    }

    REMAINING_TABLE = {
      'EV' => 'AF',
      /[AEIOU]+/ => 'A',
      'Q' => 'G',
      'Z' => 'S',
      'M' => 'N',
      'KN' => 'N',
      'K' => 'C',
      'SCH' => 'SSS',
      'PH' => 'FF',
      /([^AEIOU])H/ => '\1',
      /(.)H[^AEIOU]/ => '\1',
      /[AEIOU]W/ => 'A'
    }

    LAST_TABLE = {
      /S$/ => '',
      /AY$/ => 'Y',
      /A$/ => ''
    }

    # Convert word to its NYSIIS code
    def self.encode_word(word, options = { trim: true })
      return if !word or word.empty?
      trim = options[:trim]
      w = word.upcase
      w.gsub!(/[^A-Z]/, '')
      return if w.empty?
      FIRST_CHAR_TABLE.each{ |rx, str| break if w.sub!(rx, str) }
      LAST_CHAR_TABLE.each{ |rx, str| w.sub!(rx, str) }
      first = w[0]
      w = w[1...w.size].to_s
      REMAINING_TABLE.each{ |rx, str| w.gsub!(rx, str) }
      LAST_TABLE.each{ |rx, str| w.gsub!(rx, str) }
      w.gsub!(/[^\w\s]|(.)(?=\1)/, '') # remove duplicates
      w = first + w
      w = w[0..5] if trim
      w
    end
  end
end
