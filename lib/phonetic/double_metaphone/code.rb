require 'phonetic/algorithm'

module Phonetic
  class DoubleMetaphone < Algorithm
    class Code
      def initialize
        @codes = ['', '']
      end

      def add(primary, secondary)
        @codes[0] += primary
        @codes[1] += secondary
      end

      def results(size)
        [first[0, size], last[0, size]]
      end

      def first
        @codes.first
      end

      def last
        @codes.last
      end
    end
  end
end
