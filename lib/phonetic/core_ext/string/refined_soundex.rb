require 'phonetic/refined_soundex'

class String
  # Refined Soundex value of string.
  # @example
  #    'Caren'.refined_soundex   # => 'C30908'
  #    'Hayers'.refined_soundex  # => 'H093'
  #    'Lambard'.refined_soundex # => 'L7081096'
  def refined_soundex(options = { trim: true })
    Phonetic::RefinedSoundex.encode(self, options)
  end
end
