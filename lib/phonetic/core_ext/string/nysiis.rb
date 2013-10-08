require 'phonetic/nysiis'

class String
  def nysiis(options = {trim: true})
    Phonetic::NYSIIS.code(self, options)
  end
end