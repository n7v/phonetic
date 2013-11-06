require 'phonetic/algorithm'

module Phonetic
  # This class implements Refined NYSIIS algorithm.
  # @see http://www.dropby.com/NYSIIS.html NYSIIS Code
  # @example
  #    Phonetic::RefinedNYSIIS.encode('Aumont') # => 'ANAD'
  #    Phonetic::RefinedNYSIIS.encode('Schmidt') # => 'SNAD'
  #    Phonetic::RefinedNYSIIS.encode('Phoenix') # => 'FANAC'
  class RefinedNYSIIS < Algorithm
    FIRST_MAP = {
      /[SZ]+$/ => '',
      /^MAC/ => 'MC',
      /^PF/ =>  'F',
      /IX$/  => 'IC',
      /EX$/  => 'EC',
      /(YE|EE|IE)$/ => 'Y',
      /(DT|RT|RD|NT|ND)$/ => 'D',
      /(.)EV/ => '\1EF'
    }

    SECOND_MAP = {
      /([AEIOU])W/ => '\1',
      /[AEIOU]+/ => 'A',
      'GHT' => 'GT',
      'DG' => 'G',
      'PH' => 'F',
      'AH' => 'A',
      /(.)HA/ => '\1A',
      'KN' => 'N',
      'K' => 'C',
      /(.)M/ => '\1N',
      /(.)Q/ => '\1G',
      'SH' => 'S',
      'SCH' => 'S',
      'YW' => 'Y',
      /(.)Y(.)/ => '\1A\2',
      'WR' => 'R',
      /(.)Z/ => '\1S',
      /AY$/ => 'Y',
      /A+$/ => '',
      /[^\w\s]|(.)(?=\1)/ => ''
    }

    # Convert string to Refined NYSIIS code
    def self.encode(str, options = { trim: true })
      self.encode_word(str, options)
    end

    # Convert word to its Refined NYSIIS code
    def self.encode_word(word, options = { trim: true })
      return '' if !word or word.empty?
      trim = options[:trim]
      w = word.upcase.strip
      w.gsub! /\s([IV]+|[JS]R)$/, ''
      w.gsub! /[^A-Z]/, ''
      return if w.empty?
      FIRST_MAP.each{ |rx, v| w.gsub!(rx, v) }
      first_char = w[0]
      SECOND_MAP.each{ |rx, v| w.gsub!(rx, v) }
      w.gsub! /^A*/, first_char if vowel?(first_char)
      w = w[0..5] if trim
      w
    end

    private

    def self.vowel?(char)
      char =~ /^[AEIOU]/
    end
  end
end
