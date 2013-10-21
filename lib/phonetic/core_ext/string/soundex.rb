require 'phonetic/soundex'

class String
  # Soundex value of string
  # @example
  #    'Ackerman'.soundex # => 'A265'
  #    'ammonium'.soundex # => 'A500'
  #    'implementation'.soundex # => 'I514'
  def soundex(options = { trim: true })
    Phonetic::Soundex.encode(self, options)
  end
end
