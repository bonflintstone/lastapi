require 'rspec'
require_relative '../lib/lastpass_api'

RSpec.describe Lastpass do
  describe 'self.startup' do
    it 'Loads the config' do
      expect(true).to eq(true)
    end
  end
end
