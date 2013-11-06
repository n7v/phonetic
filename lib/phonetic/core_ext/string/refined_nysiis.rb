require 'phonetic/refined_nysiis'

class String
  # Refined NYSIIS value of string.
  # @example
  #    'Aumont'.refined_nysiis  # => 'ANAD'
  #    'Phoenix'.refined_nysiis # => 'FANAC'
  #    'Schmidt'.refined_nysiis # => 'SNAD'
  def refined_nysiis(options = { trim: true })
    Phonetic::RefinedNYSIIS.encode(self, options)
  end
end
