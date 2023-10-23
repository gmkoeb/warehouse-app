require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe 'valid?' do
    context 'presence' do
      it 'returns false when name is empty' do
        # Arrange
        new_warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço', cep: '25000-000',
                                  city: 'Rio de Janeiro', area: 1000, description: 'Galpão do rio')
        # Act
        result = new_warehouse.valid?
        # Assert
        expect(result).to eq false
      end    

      it 'returns false when code is empty' do
        # Arrange
        new_warehouse = Warehouse.new(name: 'Galpão Rio de Janeiro', code: '', address: 'Endereço', cep: '25000-000',
                                  city: 'Rio de Janeiro', area: 1000, description: 'Galpão do rio')
        # Act
        result = new_warehouse.valid?
        # Assert
        expect(result).to eq false
      end    

      it 'returns false when address is empty' do
        # Arrange
        new_warehouse = Warehouse.new(name: 'Galpão Rio de Janeiro', code: 'RIO', address: '', cep: '25000-000',
                                  city: 'Rio de Janeiro', area: 1000, description: 'Galpão do rio')
        # Act
        result = new_warehouse.valid?
        # Assert
        expect(result).to eq false
      end    

      it 'returns false when cep is empty' do
        # Arrange
        new_warehouse = Warehouse.new(name: 'Galpão Rio de Janeiro', code: 'RIO', address: 'Endereço', cep: '',
                                  city: 'Rio de Janeiro', area: 1000, description: 'Galpão do rio')
        # Act
        result = new_warehouse.valid?
        # Assert
        expect(result).to eq false
      end    

      it 'returns false when city is empty' do
        # Arrange
        new_warehouse = Warehouse.new(name: 'Galpão Rio de Janeiro', code: 'RIO', address: 'Endereço', cep: '25000-000',
                                  city: '', area: 1000, description: 'Galpão do rio')
        # Act
        result = new_warehouse.valid?
        # Assert
        expect(result).to eq false
      end    

      it 'returns false when city is empty' do
        # Arrange
        new_warehouse = Warehouse.new(name: 'Galpão Rio de Janeiro', code: 'RIO', address: 'Endereço', cep: '25000-000',
                                  city: '', area: 1000, description: 'Galpão do rio')
        # Act
        result = new_warehouse.valid?
        # Assert
        expect(result).to eq false
      end    

      it 'returns false when area is empty' do
        # Arrange
        new_warehouse = Warehouse.new(name: 'Galpão Rio de Janeiro', code: 'RIO', address: 'Endereço', cep: '25000-000',
                                  city: 'Rio de Janeiro', area: '', description: 'Galpão do rio')
        # Act
        result = new_warehouse.valid?
        # Assert
        expect(result).to eq false
      end    

      it 'returns false when description is empty' do
        # Arrange
        new_warehouse = Warehouse.new(name: 'Galpão Rio de Janeiro', code: 'RIO', address: 'Endereço', cep: '25000-000',
                                  city: 'Rio de Janeiro', area: 1000, description: '')
        # Act
        result = new_warehouse.valid?
        # Assert
        expect(result).to eq false
      end    
    end

    context 'uniqueness' do
      it 'false when code is already in use' do
        # Arrange
        first_warehouse = Warehouse.create(name: 'Galpão Rio', code: 'RIO', address: 'Endereço', cep: '25000-000',
        city: 'Rio de Janeiro', area: 1000, description: 'Galpão do rio')

        second_warehouse = Warehouse.new(name: 'Galpão Niteroi', code: 'RIO', address: 'Endereço 2', cep: '45000-000',
        city: 'Niteroi', area: 12000, description: 'Galpão de Niteroi')
        # Act
        result = second_warehouse.valid?
        # Assert
        expect(result).to eq(false)
      end
    end
  end
end
