# frozen_string_literal: true

require 'spec_helper'
require 'securerandom'

class FooService
  extend ActiveMemoize::Klass

  def custom
    SecureRandom.hex(10)
  end

  memoize :custom, as: 'custom_name'

  def random(length = 10)
    SecureRandom.hex(length)
  end

  memoize :random

end

RSpec.describe ActiveMemoize::Klass do
  subject { FooService.new }

  let(:service) { subject }

  describe '.memoize' do
    it 'returns same string twice' do
      old_random_string = service.random
      new_random_string = service.random

      expect(old_random_string).to eq(new_random_string)
    end

    it 'returns hash key with custom name' do
      old_custom_string = service.random(12)
      new_custom_string = service.random(12)

      expect(old_custom_string).to eq(new_custom_string)
    end
  end

end
