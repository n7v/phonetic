# Phonetic
[![Gem Version](https://badge.fury.io/rb/phonetic.png)](http://badge.fury.io/rb/phonetic)

Ruby library for phonetic algorithms.
It supports Soundex, Metaphone, Double Metaphone, Caverphone, NYSIIS and others.

## Installation

Add this line to your application's Gemfile:

    gem 'phonetic'

And then execute:

```shell
$ bundle
```

Or install it yourself as:

```shell
$ gem install phonetic
```

## Usage

```ruby
require 'phonetic'
```

### Soundex

```ruby
'Ackerman'.soundex # => 'A265'
'ammonium'.soundex # => 'A500'
'implementation'.soundex # => 'I514'
```

### Refined Soundex

```ruby
'Caren'.refined_soundex   # => 'C30908'
'Hayers'.refined_soundex  # => 'H093'
'Lambard'.refined_soundex # => 'L7081096'
```

### Metaphone

```ruby
'Accola'.metaphone # => 'AKKL'
'Nikki'.metaphone # => 'NK'
'Wright'.metaphone #=> 'RT'
```

### Double Metaphone

```ruby
'czerny'.double_metaphone # => ['SRN', 'XRN']
'dumb'.double_metaphone   # => ['TM', 'TM']
'edgar'.double_metaphone  # => ['ATKR', 'ATKR']
```

or use alias:

```ruby
'czerny'.metaphone2 # => ['SRN', 'XRN']
'dumb'.metaphone2   # => ['TM', 'TM']
'edgar'.metaphone2  # => ['ATKR', 'ATKR']
```

### Caverphone

```ruby
'Lashaunda'.caverphone # => 'LSNT11'
'Vidaurri'.caverphone # => 'FTR111'
````

### Caverphone 2

```ruby
'Stevenson'.caverphone2 # => 'STFNSN1111'
'Peter'.caverphone2 # => 'PTA1111111'
```

### NYSIIS

```ruby
'Alexandra'.nysiis # => 'ALAXANDR'
'Aumont'.nysiis # => 'AANAD'
'Bonnie'.nysiis # => 'BANY'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
