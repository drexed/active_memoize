# frozen_string_literal: true

require 'digest'

module ActiveMemoize
  module Shared

    def cache
      @cache ||= {}
    end

    def key(method_name, method_args)
      method_sha1 = Digest::SHA1.hexdigest(method_args.to_s)
      "#{method_name}:#{method_sha1}"
    end

  end
end
