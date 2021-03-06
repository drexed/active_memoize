# frozen_string_literal: true

require 'spec_helper'

class SharedFooService
  extend ActiveMemoize::Shared
end

RSpec.describe ActiveMemoize::Shared do
  subject { SharedFooService.new }

  let(:service) { SharedFooService }

  describe '.cache' do
    it 'returns {}' do
      expect(service.cache).to eq({})
    end
  end

  describe '.key' do
    key = 'random:dd7878149a8196d5b21abf3f51532dd46d79c471'

    it "returns '#{key}'" do
      expect(service.key('random', [1,{},[]])).to eq(key)
    end

    it 'returns "random"' do
      expect(service.key('random', [])).to eq('random')
    end
  end

end
