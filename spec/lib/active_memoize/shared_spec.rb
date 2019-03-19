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
    key = 'random:2384ba6a1157c108280c1e868d9d94a3'

    it "returns '#{key}'" do
      expect(service.key('random', [1,{},[]])).to eq(key)
    end
  end

end
