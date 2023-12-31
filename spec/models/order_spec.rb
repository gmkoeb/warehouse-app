require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid' do
    context 'code' do
      it 'must have a code' do
        # Arrange
        user = User.create!(name: 'Sergio', email: 'sergio@yahoo.com', password: '123456789')
        warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', 
                                      area:60_000, address: 'Rua das Flores, 302', 
                                      cep: '31412', description: 'Galpão localizado na rua das flores na cidade do Rio de Janeiro' )
        supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                        full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
        order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.today + 1)
        # Act
        result = order.valid?
        # Assert
        expect(result).to be true
      end
    end

    context 'estimated delivery date' do 
      it 'must be present' do
        # Arrange
        user = User.create!(name: 'Sergio', email: 'sergio@yahoo.com', password: '123456789')
        warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', 
                                      area:60_000, address: 'Rua das Flores, 302', 
                                      cep: '31412', description: 'Galpão localizado na rua das flores na cidade do Rio de Janeiro' )
        supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                        full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
        order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '')
        # Act
        order.valid?          
        result = order.errors.include?(:estimated_delivery_date)                     
        # Assert
        expect(result).to be true
      end
  
      it 'escant be in the past' do
        # Arrange
        order = Order.new(estimated_delivery_date: 1.day.ago)
        # Act
        order.valid?
        result = order.errors.include?(:estimated_delivery_date)
        # Assert
        expect(result).to be true
        expect(order.errors[:estimated_delivery_date]).to include "deve ser futura."
      end
  
      it 'cant be today' do
        # Arrange
        order = Order.new(estimated_delivery_date: Date.today)
        # Act
        order.valid?
        result = order.errors.include?(:estimated_delivery_date)
        # Assert
        expect(result).to be true
        expect(order.errors[:estimated_delivery_date]).to include "deve ser futura."
      end
  
      it 'must be equal or higher than tomorrow' do
        # Arrange
        order = Order.new(estimated_delivery_date: 1.day.from_now)
        # Act
        order.valid?
        result = order.errors.include?(:estimated_delivery_date)
        # Assert
        expect(result).to be false
      end
    end
  end

  describe 'generates random code' do
    it 'on order creation' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@yahoo.com', password: '123456789')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', 
                                    area:60_000, address: 'Rua das Flores, 302', 
                                    cep: '31412', description: 'Galpão localizado na rua das flores na cidade do Rio de Janeiro' )
      supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                      full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)
      # Act
      order.save!
      result = order.code
      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end

    it 'and the code is unique' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@yahoo.com', password: '123456789')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', 
                                    area:60_000, address: 'Rua das Flores, 302', 
                                    cep: '31412', description: 'Galpão localizado na rua das flores na cidade do Rio de Janeiro' )
      supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                      full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)
      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)
      # Act
      second_order.save!
      # Assert
      expect(second_order.code).not_to eq first_order.code
    end

    it 'cant be modified' do
      user = User.create!(name: 'Sergio', email: 'sergio@yahoo.com', password: '123456789')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', 
                                    area:60_000, address: 'Rua das Flores, 302', 
                                    cep: '31412', description: 'Galpão localizado na rua das flores na cidade do Rio de Janeiro' )
      supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                      full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)
      original_code = order.code
      # Act
      order.update!(estimated_delivery_date: Date.today + 30)
      # Assert
      expect(order.code).to eq original_code

    end
  end
  
end
