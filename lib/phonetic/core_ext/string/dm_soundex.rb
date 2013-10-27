require 'phonetic/dm_soundex'

class String
  # D-M Soundex values of string.
  # @example
  #    'Anja'.dm_soundex # => ['060000', '064000']
  #    'Schwarz'.dm_soundex # => ['474000', '479400']
  #    'Schtolteheim'.dm_soundex # => ['283560']
  def dm_soundex(options = {})
    Phonetic::DMSoundex.encode(self, options)
  end
end
