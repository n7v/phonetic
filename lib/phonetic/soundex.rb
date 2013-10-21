require 'phonetic/algorithm'

module Phonetic
  # Soundex phonetic algorithm was developed by Robert C. Russell and Margaret K. Odell.
  # This class implements American Soundex version of algorithm.
  #
  # @example
  #    Phonetic::Soundex.encode('Ackerman') # => 'A265'
  #    Phonetic::Soundex.encode('ammonium') # => 'A500'
  #    Phonetic::Soundex.encode('implementation') # => 'I514'
  class Soundex < Algorithm
    CODE = {
      B: 1, P: 1, F: 1, V: 1,
      C: 2, S: 2, K: 2, G: 2, J: 2, Q: 2, X: 2, Z: 2,
      D: 3, T: 3,
      L: 4,
      M: 5, N: 5,
      R: 6
    }

    # Convert word to its Soundex code
    def self.encode_word(word, options = {})
      return '' if word.empty?
      w = word.upcase
      res = w[0]
      pg = CODE[w[0].to_sym]
      (1...w.size).each do |i|
        g = CODE[w[i].to_sym]
        if g and pg != g
          res += g.to_s
          pg = g
        end
        break if res.size > 3
      end
      res = res.ljust(4, '0')
      res
    end
  end
end
