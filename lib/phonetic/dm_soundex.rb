require 'phonetic/algorithm'
require 'phonetic/dm_soundex_map'

module Phonetic
  # Daitch–Mokotoff Soundex (D–M Soundex) is a phonetic algorithm invented
  # in 1985 by Jewish genealogists Gary Mokotoff and Randy Daitch.
  #
  # @example
  #    Phonetic::DMSoundex.encode('Anja') # => ['060000', '064000']
  #    Phonetic::DMSoundex.encode('Schwarz') # => ['474000', '479400']
  #    Phonetic::DMSoundex.encode('Schtolteheim') # => ['283560']
  class DMSoundex < Algorithm

    def self.encode(str, options = {})
      encode_word(str, options)
    end

    # Encode word to its D-M Soundex codes.
    def self.encode_word(word, options = {})
      w = word.strip.upcase.gsub(/[^A-Z]+/, '')
      i = 0
      code = init_code()
      while i < w.size
        if w[i] != w[i + 1]
          c = find_code(MAP, w, i)
          if c
            len = c[3] + 1
            if i == 0
              code.add c[0]
            elsif w[i + len] =~ /[AEIOUJY]/
              code.add c[1]
            else
              code.add c[2]
            end
            i += c[3]
          end
        end
        i += 1
      end
      code.result
    end

    private

    def self.init_code
      code = [[]]
      def code.add(a)
        case a
        when Array
          c = self.map{|w| w.last != a[1] ? w + [a[1]] : w}
          self.map!{|w| w.last != a[0] ? w + [a[0]] : w}
          self.push(*c)
        else
          self.map!{|w| w.last != a ? w + [a] : w}
        end
      end
      def code.result
        self.map{|w| w.join[0..5].ljust(6, '0')}.uniq
      end
      code
    end

    def self.find_code(map, w, i, last = nil, count = 0)
      elem = map[w[i]]
      r = case elem
          when Array
            elem[3] = count
            elem
          when Hash
            _last = last
             if elem['self']
              _last = elem['self']
              _last[3] = count
            end
            find_code(elem, w, i + 1, _last, count + 1)
          when nil
            last
          end
      r
    end
  end
end
