require 'phonetic/double_metaphone'

class String
  def double_metaphone(options = { size: 4 })
    Phonetic::DoubleMetaphone.encode(self, options)
  end

  alias_method :metaphone2, :double_metaphone
end
