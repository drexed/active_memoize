# ActiveMemoize

[![Gem Version](https://badge.fury.io/rb/active_memoize.svg)](http://badge.fury.io/rb/active_memoize)
[![Build Status](https://travis-ci.org/drexed/active_memoize.svg?branch=master)](https://travis-ci.org/drexed/active_memoize)

ActiveMemoize provides an API caching and memoizing local
expensive calculations including those with parameters.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_memoize'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_memoize

## Table of Contents

* [Usage](#usage)

## Usage

```ruby
class Movies

  def cache
    @cache ||= ActiveMemoize::Cache.new
  end

  def random
    cache['random'] ||= HTTP.get('http://movies.com/any')
  end

  def search(title, force = false)
    cache.clear if force

    cache.memoize do
      HTTP.get("http://movies.com?title=#{title}")
    end
  end

end
```

## Contributing

Your contribution is welcome.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
