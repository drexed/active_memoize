# ActiveMemoize

[![Gem Version](https://badge.fury.io/rb/active_memoize.svg)](http://badge.fury.io/rb/active_memoize)
[![Build Status](https://travis-ci.org/drexed/active_memoize.svg?branch=master)](https://travis-ci.org/drexed/active_memoize)

**NOTE** ActiveMemoize has been deprecated in favor of [Lite::Memoize](https://github.com/drexed/lite-memoize). Its a drop-in replacement, so please make the switch as soon as possible.

ActiveMemoize provides an API caching and memoizing local
expensive calculations including those with parameters.

The flexible API allows you to memoize results using class
or instance level cache.

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

* [Klass](#klass)
* [Instance](#instance)

## Klass

Class level memoization is the quickest way to get up and running using your cache, but provides the least amount of flexibility. You can only cache results
without access to any information about your cache.

```ruby
class Movies
  extend ActiveMemoize::Klass

  def random
    HTTP.get('http://movies.com/any')
  end

  memoize :random

  def search(title)
    HTTP.get("http://movies.com?title=#{title}")
  end

  memoize :search, as: :find

end
```

## Instance

Instance level memoization is a more involved way to setup your cache, but provides the most amount of flexibility. You can access almost all methods
in the `instance.rb` file.

```ruby
class Movies

  def cache
    @cache ||= ActiveMemoize::Instance.new
  end

  def all
    cache.memoize { HTTP.get("http://movies.com/all") }
  end

  def random
    cache['random'] ||= HTTP.get('http://movies.com/any')
  end

  def search(title)
    cache.memoize(as: :find, refresh: !cache.empty?) do
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
