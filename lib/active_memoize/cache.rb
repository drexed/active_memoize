# frozen_string_literal: true

module ActiveMemoize
  class Cache

    CALLER_METHOD_REGEX ||= /`([^']*)'/.freeze

    attr_reader :cache

    def initialize
      @cache = {}
    end

    def [](key)
      @cache[key]
    end

    def []=(key, val)
      @cache[key] = val
    end

    def clear
      @cache.clear
    end

    def delete(key)
      @cache.delete(key)
    end

    # :nocov:
    def each
      @cache.each { |key, val| yield(key, val) }
    end
    # :nocov:

    def empty?
      @cache.empty?
    end

    alias_method :blank?, :empty?

    def key?(key)
      @cache.key?(key)
    end

    alias_method :hit?, :key?

    def keys
      @cache.keys
    end

    def merge!(hash)
      @cache.merge!(hash)
    end

    def memoize(&block)
      method_name = "#{caller_method}:#{caller_locals(block)}"
      return @cache[method_name] if @cache.key?(method_name)

      @cache[method_name] = yield(block)
    end

    def present?
      !blank?
    end

    alias_method :hits?, :present?

    def size
      @cache.size
    end

    def to_hash
      @cache
    end

    alias_method :as_json, :to_hash
    alias_method :hits, :to_hash

    def values
      @cache.values
    end

    private

    # rubocop:disable Metrics/LineLength
    def caller_locals(block)
      local_vars = block.binding.local_variables
      local_vars = local_vars.flat_map { |name| [name, block.binding.local_variable_get(name)].join('=') }
      local_vars.join(',')
    end
    # rubocop:enable Metrics/LineLength

    def caller_method
      val = caller(2..2).first[CALLER_METHOD_REGEX, 1]
      return val unless val.include?('<top (required)>')

      caller(1..1).first[CALLER_METHOD_REGEX, 1]
    end

  end
end
