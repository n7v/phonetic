require 'phonetic/caverphone'

class String
  # Caverphone value of string
  # @example
  #    'Lashaunda'.caverphone # => 'LSNT11'
  #    'Vidaurri'.caverphone # => 'FTR111'
  def caverphone(options = {})
    Phonetic::Caverphone.encode(self, options)
  end
end
