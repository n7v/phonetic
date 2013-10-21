require 'phonetic/caverphone2'

class String
  # Caverphone 2 value of string
  # @example
  #    'Stevenson'.caverphone2 # => 'STFNSN1111'
  #    'Peter'.caverphone2 # => 'PTA1111111'
  def caverphone2(options = {})
    Phonetic::Caverphone2.encode(self, options)
  end
end
