require 'phonetic/algorithm'

module Phonetic
  # Metaphone is a phonetic algorithm, published by Lawrence Philips in 1990,
  # for indexing words by their English pronunciation.
  # This class implements this algorithm.
  # @see http://aspell.net/metaphone/metaphone.basic Original Basic code by Lawrence Philips (1990)
  # @example
  #    Phonetic::Metaphone.encode('Accola') # => 'AKKL'
  #    Phonetic::Metaphone.encode('Nikki') # => 'NK'
  #    Phonetic::Metaphone.encode('Wright') #=> 'RT'
  class Metaphone < Algorithm
    VOWELS = 'AEIOU'
    FRONT_VOWELS = 'EIY'
    VARSON = 'CSPTG'

    # Encode word to its Metaphone code
    def self.encode_word(word, options = { size: 4 })
      code_size = options[:size] || 4
      w = word.upcase.gsub(/[^A-Z]/, '')
      return if w.empty?
      two = w[0, 2]
      w[0] = ''  if two =~ /PN|AE|KN|GN|WR/
      w[0] = 'S' if w[0] == 'X'
      w[1] = ''  if two == 'WH'
      l = w.size
      metaph = ''
      for n in 0..(l - 1)
        break unless metaph.size < code_size
        symb = w[n]
        if symb == 'C' || n == 0 || w[n - 1] != symb
          case
          when vowel?(symb) && n == 0
            metaph = symb
          when symb == 'B'
            metaph += symb if n != l - 1 || w[n - 1] != 'M'
          when symb == 'C'
            if n == 0 || w[n - 1] != 'S' || !front_vowel?(w[n + 1])
              if w[n + 1, 2] == 'IA'
                metaph += 'X'
              elsif front_vowel?(w[n + 1])
                metaph += 'S'
              elsif n > 0 && w[n + 1] == 'H' && w[n - 1] == 'S'
                metaph += 'K'
              elsif w[n + 1] == 'H'
                if n == 0 && !vowel?(w[n + 2])
                  metaph += 'K'
                else
                  metaph += 'X'
                end
              else
                metaph += 'K'
              end
            end
          when symb == 'D'
            if w[n + 1] == 'G' && front_vowel?(w[n + 2])
              metaph += 'J'
            else
              metaph += 'T'
            end
          when symb == 'G'
            silent = (w[n + 1] == 'H' && !vowel?(w[n + 2]))
            if n > 0 && (w[n + 1] == 'N' || w[n + 1, 3] == 'NED')
              silent = true
            end
            if n > 0 && w[n - 1] == 'D' && front_vowel?(w[n + 1])
              silent = true
            end
            hard = (n > 0 && w[n - 1] == 'G')
            unless silent
              if front_vowel?(w[n + 1]) && !hard
                metaph += 'J'
              else
                metaph += 'K'
              end
            end
          when symb == 'H'
            if !(n == l - 1 || (n > 0 && VARSON[w[n - 1]]))
              metaph += 'H' if vowel?(w[n + 1])
            end
          when symb =~ /[FJLMNR]/
            metaph += symb
          when symb == 'K'
            if n > 0 && w[n - 1] != 'C'
              metaph += 'K'
            elsif n == 0
              metaph = 'K'
            end
          when symb == 'P'
            metaph += w[n + 1] == 'H' ? 'F' : 'P'
          when symb == 'Q'
            metaph += 'K'
          when symb == 'S'
            if w[n + 1, 2] =~ /I[OA]/
              metaph += 'X'
            elsif w[n + 1] == 'H'
              metaph += 'X'
            else
              metaph += 'S'
            end
          when symb == 'T'
            if w[n + 1, 2] =~ /I[OA]/
              metaph += 'X'
            elsif w[n + 1] == 'H'
              metaph += '0' if n == 0 || w[n - 1] != 'T'
            else
              metaph += 'T' if w[n + 1, 2] != 'CH'
            end
          when symb == 'V'
            metaph += 'F'
          when symb =~ /[WY]/
            metaph += symb if vowel?(w[n + 1])
          when symb == 'X'
            metaph += 'KS'
          when symb == 'Z'
            metaph += 'S'
          end
        end
      end
      metaph
    end

    private

    def self.vowel?(symbol)
      v = VOWELS[symbol.to_s]
      !v.nil? && !v.empty?
    end

    def self.front_vowel?(symbol)
      v = FRONT_VOWELS[symbol.to_s]
      !v.nil? && !v.empty?
    end
  end
end
