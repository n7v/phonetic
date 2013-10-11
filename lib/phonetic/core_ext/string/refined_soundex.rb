require 'phonetic/refined_soundex'

class String
  def refined_soundex(options = { trim: true })
    Phonetic::RefinedSoundex.encode(self, options)
  end
end
