module Phonetic
  # Base class for phonetic algorithms.
  class Algorithm
    # Generic method for encoding single word. Override it in your algorithm class.
    # @param [String] word the word to encode
    # @param [Hash] options the options for the algorithm
    # @return [String] the word
    def self.encode_word(word, options = {})
      word
    end

    # Generic method for encoding string.
    # Splits string by words and encodes it with {Algorithm.encode_word}.
    #
    # @param [String] str the string to encode.
    # @param [Hash] options the options for algorithm.
    # @return [String] the space separated codes of words from input string.
    def self.encode(str, options = {})
      str.scan(/\p{Word}+/).map do |word|
        encode_word(word, options)
      end.compact.reject(&:empty?).join(' ')
    end
  end
end
