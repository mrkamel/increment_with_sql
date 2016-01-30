# IncrementWithSql

[![Build Status](https://secure.travis-ci.org/mrkamel/increment_with_sql.png?branch=master)](http://travis-ci.org/mrkamel/increment_with_sql)
[![Dependency Status](https://gemnasium.com/mrkamel/increment_with_sql.png?travis)](https://gemnasium.com/mrkamel/increment_with_sql)
[![Gem Version](https://badge.fury.io/rb/increment_with_sql.svg)](http://badge.fury.io/rb/increment_with_sql)

Provides `#increment_with_sql!` and `#decrement_with_sql!` for ActiveRecord::Base,
since ActiveRecord's bulti-in non-atomic `#increment` and `#decrement` methods don't
provide database consistency.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'increment_with_sql'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install increment_with_sql

## Usage

It's simple:

```ruby
class MyModel < ActiveRecord::Base
  def increment_counter!
    increment_with_sql! :counter
  end

  def decrement_counter!
    decrement_with_sql! :counter
  end
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/increment_with_sql/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
