require 'phonetic/metaphone'

class String
  def metaphone(options = { size: 4 })
    Phonetic::Metaphone.encode(self, options)
  end
end
