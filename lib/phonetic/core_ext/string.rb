Gem.find_files('phonetic/core_ext/string/*.rb')
   .reject{|path| path =~ /_spec/}
   .each { |path| require path }
