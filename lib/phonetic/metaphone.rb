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
      if ['PN', 'AE', 'KN', 'GN', 'WR'].include?(two) then w[0] = '' end
      if w[0] == 'X' then w[0] = 'S' end
      if two == 'WH' then w[1] = '' end
      l = w.size
      metaph = ''
      for n in 0..(l - 1)
        break unless metaph.size < code_size
        symb = w[n]
        if !(symb != 'C' && n > 0 && w[n - 1] == symb)
          case
          when vowel?(symb) && n == 0
            metaph = symb
          when symb == 'B'
            unless n == l - 1 && w[n - 1] == 'M'
              metaph = metaph + symb
            end
          when symb == 'C'
            if !(n > 0 && w[n - 1] == 'S' && front_vowel?(w[n + 1]))
              if w[n + 1, 2] == 'IA'
                metaph = metaph + 'X'
              else
                if front_vowel?(w[n + 1])
                  metaph = metaph + 'S'
                else
                  if n > 0 && w[n + 1] == 'H' && w[n - 1] == 'S'
                    metaph = metaph + 'K'
                  else
                    if w[n + 1] == 'H'
                      if n == 0 && !vowel?(w[n + 2])
                        metaph = metaph + 'K'
                      else
                        metaph = metaph + 'X'
                      end
                    else
                      metaph = metaph + 'K'
                    end
                  end
                end
              end
            end
          when symb == 'D'
            if w[n + 1] == 'G' && front_vowel?(w[n + 2])
              metaph = metaph + 'J'
            else
              metaph = metaph + 'T'
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
                metaph = metaph + 'J'
              else
                metaph = metaph + 'K'
              end
            end
          when symb == 'H'
            if !(n == l - 1 || (n > 0 && VARSON[w[n - 1]]))
              if vowel?(w[n + 1])
                metaph = metaph + 'H'
              end
            end
          when 'FJLMNR'[symb]
            metaph = metaph + symb
          when symb == 'K'
            if n > 0 && w[n - 1] != 'C'
              metaph = metaph + 'K'
            else
              if n == 0
                metaph = 'K'
              end
            end
          when symb == 'P'
            if w[n + 1] == 'H'
              metaph = metaph + 'F'
            else
              metaph = metaph + 'P'
            end
          when symb == 'Q'
            metaph = metaph + 'K'
          when symb == 'S'
            if w[n + 1] == 'I' && (w[n + 2] == 'O' || w[n + 2] == 'A')
              metaph += 'X'
            else
              if w[n + 1] == 'H'
                metaph += 'X'
              else
                metaph += 'S'
              end
            end
          when symb == 'T'
            if w[n + 1] == 'I' && (w[n + 2] == 'O' || w[n + 2] == 'A')
              metaph = metaph + 'X'
            else
              if w[n + 1] == 'H'
                if !(n > 0 && w[n - 1] == 'T')
                  metaph = metaph + '0'
                end
              else
                if !(w[n + 1] == 'C' && w[n + 2] == 'H')
                  metaph = metaph + 'T'
                end
              end
            end
          when symb == 'V'
            metaph = metaph + 'F'
          when symb == 'W' || symb == 'Y'
            if vowel?(w[n + 1])
              metaph = metaph + symb
            end
          when symb == 'X'
            metaph = metaph + 'KS'
          when symb == 'Z'
            metaph = metaph + 'S'
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
