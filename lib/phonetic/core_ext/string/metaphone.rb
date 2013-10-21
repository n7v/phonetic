require 'phonetic/metaphone'

class String
  # Metaphone value of string.
  # @example
  #    'Accola'.metaphone # => 'AKKL'
  #    'Nikki'.metaphone # => 'NK'
  #    'Wright'.metaphone #=> 'RT'
  def metaphone(options = { size: 4 })
    Phonetic::Metaphone.encode(self, options)
  end
end
