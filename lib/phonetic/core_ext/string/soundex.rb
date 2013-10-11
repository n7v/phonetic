require 'phonetic/soundex'

class String
  def soundex(options = { trim: true })
    Phonetic::Soundex.encode(self, options)
  end
end
