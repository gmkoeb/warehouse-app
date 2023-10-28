require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    it 'returns true when all fields are filled' do
      # Arrange
      new_supplier = Supplier.new(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                  full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
      # Act
      result = new_supplier.valid?
      # Assert
      expect(result).to eq(true)
    end

    it 'returns false when corporate_name is empty' do
      # Arrange
      new_supplier = Supplier.new(corporate_name: '', brand_name: 'Razer', registration_number: '131341', 
                                  full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
      # Act
      result = new_supplier.valid?
      # Assert
      expect(result).to eq(false)
    end

    it 'returns false when brand_name is empty' do
      # Arrange
      new_supplier = Supplier.new(corporate_name: 'Razer Eletronics', brand_name: '', registration_number: '131341', 
                                  full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
      # Act
      result = new_supplier.valid?
      # Assert
      expect(result).to eq(false)
    end

    it 'returns false when registration_number is empty' do
      # Arrange
      new_supplier = Supplier.new(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '', 
                                  full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
      # Act
      result = new_supplier.valid?
      # Assert
      expect(result).to eq(false)
    end

    it 'returns false when full_address is empty' do
      # Arrange
      new_supplier = Supplier.new(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                  full_address: '', city: 'New York', state: 'NY', email: 'razer@gmail.com')
      # Act
      result = new_supplier.valid?
      # Assert
      expect(result).to eq(false)
    end

    it 'returns false when city is empty' do
      # Arrange
      new_supplier = Supplier.new(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                  full_address: 'Wall Street, 341', city: '', state: 'NY', email: 'razer@gmail.com')
      # Act
      result = new_supplier.valid?
      # Assert
      expect(result).to eq(false)
    end
    
    it 'returns false when state is empty' do
      # Arrange
      new_supplier = Supplier.new(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                  full_address: 'Wall Street, 341', city: 'New York', state: '', email: 'razer@gmail.com')
      # Act
      result = new_supplier.valid?
      # Assert
      expect(result).to eq(false)
    end

    it 'returns false when email is empty' do
      # Arrange
      new_supplier = Supplier.new(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                  full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: '')
      # Act
      result = new_supplier.valid?
      # Assert
      expect(result).to eq(false)
    end

    it 'returns false when brand_name isnt unique' do
      # Arrange
      new_supplier_1 = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                    full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
      new_supplier_2 = Supplier.new(corporate_name: 'Raser Eletronicos', brand_name: 'Razer', registration_number: '431341', 
                                    full_address: 'China Town, 3431', city: 'New York', state: 'NY', email: 'raser@gmail.com')
      # Act
      result = new_supplier_2.valid?
      # Assert
      expect(result).to eq(false)
    end

    it 'returns false when registration_number isnt unique' do
      # Arrange
      new_supplier_1 = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                    full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
      new_supplier_2 = Supplier.new(corporate_name: 'Raser Eletronicos', brand_name: 'Raser Eletronics', registration_number: '131341', 
                                    full_address: 'China Town, 3431', city: 'New York', state: 'NY', email: 'raser@gmail.com')
      # Act
      result = new_supplier_2.valid?
      # Assert
      expect(result).to eq(false)
    end
  end
end
