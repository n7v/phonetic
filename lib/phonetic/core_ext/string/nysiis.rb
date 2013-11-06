require 'phonetic/nysiis'

class String
  # NYSIIS value of string.
  # @example
  #    'Alexandra'.nysiis # => 'ALAXANDR'
  #    'Aumont'.nysiis # => 'AANAD'
  #    'Bonnie'.nysiis # => 'BANY'
  def nysiis(options = { trim: true })
    Phonetic::NYSIIS.encode(self, options)
  end
end
