# frozen_string_literal: true

%w[version shared klass instance].each do |file_name|
  require "active_memoize/#{file_name}"
end
