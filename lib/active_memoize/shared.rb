# frozen_string_literal: true

require 'digest'

module ActiveMemoize
  module Shared

    def cache
      @cache ||= {}
    end

    def key(method_name, method_args)
      method_md5 = Digest::MD5.hexdigest(method_args.to_s)
      "#{method_name}:#{method_md5}"
    end

  end
end
