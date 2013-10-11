module Phonetic
  class Algorithm
    def self.encode_word(word, options = {})
      word
    end

    def self.encode(str, options = {})
      str.split(/\s+/).map do |word|
        encode_word(word, options)
      end.compact.reject(&:empty?).join(' ')
    end
  end
end
