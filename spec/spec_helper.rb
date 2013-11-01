require 'coveralls'
require 'simplecov'

if RUBY_ENGINE == 'ruby'
  if Coveralls.should_run?
    Coveralls.wear!
  else
    SimpleCov.start
  end
end

require 'phonetic'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end
