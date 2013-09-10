module Phonetic
  class Soundex
    CODE = { 
      B: 1, P: 1, F: 1, V: 1,
      C: 2, S: 2, K: 2, G: 2, J: 2, Q: 2, X: 2, Z: 2,
      D: 3, T: 3,
      L: 4,
      M: 5, N: 5,
      R: 6
    }

    def self.code(word)
      return '' if word.empty?
      w = word.upcase
      res = w[0]
      (1...w.size).each do |i|
        group = CODE[w[i].to_sym].to_s
        res += group if !group.empty? && group != res[res.size-1]
        break if res.size > 3
        i+=1
      end
      res = res.ljust(4, '0')
      res
    end
  end
end