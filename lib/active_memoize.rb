# frozen_string_literal: true

%w[version cache].each do |file_name|
  require "active_memoize/#{file_name}"
end
