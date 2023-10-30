require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'shows username and email' do
      # Arrange
      u = User.new(name: 'Gabriel', email: 'gabriel@gmail.com')
      
      # Act
      result = u.description()

      # Assert
      expect(result).to eq('Gabriel - gabriel@gmail.com')
    end
  end
end
