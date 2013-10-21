require 'phonetic/double_metaphone'

class String
  # Double Metahpone code of string.
  # @example
  #    'czerny'.double_metaphone # => ['SRN', 'XRN']
  #    'dumb'.double_metaphone   # => ['TM', 'TM']
  #    'edgar'.double_metaphone  # => ['ATKR', 'ATKR']
  #    # or use alias:
  #    'czerny'.metaphone2 # => ['SRN', 'XRN']
  #    'dumb'.metaphone2   # => ['TM', 'TM']
  #    'edgar'.metaphone2  # => ['ATKR', 'ATKR']
  def double_metaphone(options = { size: 4 })
    Phonetic::DoubleMetaphone.encode(self, options)
  end

  alias_method :metaphone2, :double_metaphone
end
