# Phonetic
[![Build Status](https://travis-ci.org/n7v/phonetic.png)](https://travis-ci.org/n7v/phonetic)
[![Gem Version](https://badge.fury.io/rb/phonetic.png)](http://badge.fury.io/rb/phonetic)
[![Coverage Status](https://coveralls.io/repos/n7v/phonetic/badge.png)](https://coveralls.io/r/n7v/phonetic)
[![Code Climate](https://codeclimate.com/github/n7v/phonetic.png)](https://codeclimate.com/github/n7v/phonetic)
[![Dependency Status](https://gemnasium.com/n7v/phonetic.png)](https://gemnasium.com/n7v/phonetic)

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

## Dependencies

Ruby >= 1.9, JRuby 1.7.6, Rubinius 2.1.1

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

### Refined NYSIIS

```ruby
'Aumont'.refined_nysiis  # => 'ANAD'
'Phoenix'.refined_nysiis # => 'FANAC'
'Schmidt'.refined_nysiis # => 'SNAD'
```

### Daitch–Mokotoff Soundex (D–M Soundex)

```ruby
'Anja'.dm_soundex # => ['060000', '064000']
'Schwarz'.dm_soundex # => ['474000', '479400']
'Schtolteheim'.dm_soundex # => ['283560']
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
