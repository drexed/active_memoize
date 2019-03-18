# frozen_string_literal: true

require 'digest'

module ActiveMemoize
  module Shared

    def cache
      @cache ||= {}
    end

    def key(method_name, method_args)
      Digest::SHA1.hexdigest("#{method_name}:#{method_args}")
    end

  end
end
