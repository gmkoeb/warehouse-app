require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'generates serial number' do
    it 'on stock product creation' do
      # Arrange
      user = User.create!(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
                                    area:60_000, address: 'Rua do aeroporto, 3102', 
                                    cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
      supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                  full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
      product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', weight: 5, height: 100, width: 70, depth: 75, sku: 'CAD-GAMER-XPTO40')                     
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow, status: 'pending')   
      # Act
      stock_product = StockProduct.create!(warehouse: warehouse, order: order, product_model: product)    
      serial_number = stock_product.serial_number 
      # Assert
      expect(serial_number.length).to eq 20
    end

    it 'cant be modified' do
      # Arrange
      user = User.create!(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
                                    area:60_000, address: 'Rua do aeroporto, 3102', 
                                    cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
      supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                  full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
      product_1 = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', weight: 5, height: 100, width: 70, depth: 75, sku: 'CAD-GAMER-XPTO40')
      product_2 = ProductModel.create!(supplier: supplier, name: 'Teclado Gamer', weight: 1, height: 3, width: 40, depth: 15, sku: 'TECLADO-GAMER-XPTO40')                     
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow, status: 'pending')   
      stock_product = StockProduct.create!(warehouse: warehouse, order: order, product_model: product_1)    
      original_serial_number = stock_product.serial_number 
      # Act
      stock_product.update(product_model: product_2)
      # Assert
      expect(stock_product.serial_number).to eq original_serial_number
    end
  end
end
