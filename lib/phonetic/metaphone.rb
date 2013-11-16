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
      n = 0
      if vowel?(w[0])
        metaph = w[0]
        n = 1
      end
      while n < l && metaph.size < code_size
        symb = w[n]
        if duplicate?(w, n)
          n += 1
          next
        end
        case symb
        when /[BCDGH]/
          metaph += gen_encode(w, n)
        when /[FJLMNR]/
          metaph += symb
        when 'K'
          metaph += encode_k(w, n)
        when 'P'
          metaph += w[n + 1] == 'H' ? 'F' : 'P'
        when 'Q'
          metaph += 'K'
        when /[ST]/
          metaph += gen_encode(w, n)
        when 'V'
          metaph += 'F'
        when /[WY]/
          metaph += symb if vowel?(w[n + 1])
        when 'X'
          metaph += 'KS'
        when 'Z'
          metaph += 'S'
        end
        n += 1
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

    def self.duplicate?(w, n)
      w[n] != 'C' && n > 0 && w[n - 1] == w[n]
    end

    def self.gen_encode(w, n)
      self.send "encode_#{w[n].downcase}", w, n
    end

    def self.encode_b(w, n)
      n != w.size - 1 || w[n - 1] != 'M' ? w[n] : ''
    end

    def self.encode_c(w, n)
      metaph = ''
      if n == 0 || w[n - 1] != 'S' || !front_vowel?(w[n + 1])
        case
        when w[n + 1, 2] == 'IA'
          metaph = 'X'
        when front_vowel?(w[n + 1])
          metaph = 'S'
        when n > 0 && w[n - 1, 3] == 'SCH'
          metaph = 'K'
        when w[n + 1] == 'H'
          metaph = (n == 0 && !vowel?(w[n + 2])) ? 'K' : 'X'
        else
          metaph = 'K'
        end
      end
      metaph
    end

    def self.encode_d(w, n)
      w[n + 1] == 'G' && front_vowel?(w[n + 2]) ? 'J' : 'T'
    end

    def self.encode_g(w, n)
      metaph = ''
      silent = (w[n + 1] == 'H' && !vowel?(w[n + 2]))
      silent = true if n > 0 && w[n + 1] == 'N'
      silent = true if n > 0 && w[n - 1] == 'D' && front_vowel?(w[n + 1])
      hard = (n > 0 && w[n - 1] == 'G')
      unless silent
        metaph = (front_vowel?(w[n + 1]) && !hard) ? 'J' : 'K'
      end
      metaph
    end

    def self.encode_h(w, n)
      metaph = ''
      unless n == w.size - 1 || (n > 0 && VARSON[w[n - 1]])
        metaph = 'H' if vowel?(w[n + 1])
      end
      metaph
    end

    def self.encode_k(w, n)
      metaph = ''
      if n > 0 && w[n - 1] != 'C'
        metaph = 'K'
      elsif n == 0
        metaph = 'K'
      end
      metaph
    end

    def self.encode_s(w, n)
      metaph = ''
      if w[n + 1, 2] =~ /I[OA]/
        metaph = 'X'
      elsif w[n + 1] == 'H'
        metaph = 'X'
      else
        metaph = 'S'
      end
      metaph
    end

    def self.encode_t(w, n)
      metaph = ''
      if w[n + 1, 2] =~ /I[OA]/
        metaph = 'X'
      elsif w[n + 1] == 'H'
        metaph = '0' if n == 0 || w[n - 1] != 'T'
      else
        metaph = 'T' if w[n + 1, 2] != 'CH'
      end
      metaph
    end

  end
end
