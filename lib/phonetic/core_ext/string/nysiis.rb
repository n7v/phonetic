require 'phonetic/nysiis'

class String
  def nysiis(options = {trim: true})
    Phonetic::NYSIIS.encode(self, options)
  end
end