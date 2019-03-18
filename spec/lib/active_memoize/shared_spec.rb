# frozen_string_literal: true

require 'spec_helper'

class FooService
  extend ActiveMemoize::Klass
end

RSpec.describe ActiveMemoize::Klass do
  subject { FooService.new }

  let(:service) { FooService }

  describe '.cache' do
    it 'returns {}' do
      expect(service.cache).to eq({})
    end
  end

  describe '.key' do
    it 'returns "5e3117a609f99e88f3c70ee61c1d84a8d89b665a"' do
      expect(service.key('random', [1,{},[]])).to eq('5e3117a609f99e88f3c70ee61c1d84a8d89b665a')
    end
  end

end