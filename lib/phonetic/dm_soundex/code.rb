module Phonetic
 class DMSoundex
    class Code
      def initialize
        @codes = [[]]
      end

      def add(a)
        case a
        when Array
          c1 = add_code(a[0])
          c2 = add_code(a[1])
          @codes = c1 + c2
        else
          @codes = add_code(a)
        end
      end

      def results
        @codes.map{|w| w.join[0..5].ljust(6, '0')}.uniq
      end

      private

      def add_code(code)
        @codes.map{|w| w.last != code ? w + [code] : w}
      end
    end
  end
end
