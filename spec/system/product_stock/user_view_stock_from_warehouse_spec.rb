require 'rails_helper'

describe 'User sees stock' do
  it 'in warehouse page' do
    # Arrange
    user = User.create!(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
                                  area:60_000, address: 'Rua do aeroporto, 3102', 
                                  cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
    supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
    product_1 = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', 
                                     weight: 5, height: 100, width: 70, depth: 75, sku: 'CAD-GAMER-RZER404')
    product_2 = ProductModel.create!(supplier: supplier, name: 'Teclado Gamer', 
                                     weight: 2, height: 3, width: 40, depth: 15, sku: 'TECLADO-GAMER-RZER404')            
    product_3 = ProductModel.create!(supplier: supplier, name: 'Mouse Gamer', 
                                     weight: 1, height: 3, width: 7, depth: 12, sku: 'MOUSE-GAMER-RZER404')              
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow, status: 'pending')   
    3.times { StockProduct.create!(warehouse: warehouse, order: order, product_model: product_1) }
    2.times { StockProduct.create!(warehouse: warehouse, order: order, product_model: product_2) }
    # Act
    login_as(user)
    visit root_path                               
    click_on 'Guarulhos Aeroporto'
    # Assert
    expect(page).to have_content 'Itens em Estoque'
    expect(page).to have_content '3 x CAD-GAMER-RZER404'
    expect(page).to have_content '2 x TECLADO-GAMER-RZER404'
    expect(page).not_to have_content 'MOUSE-GAMER-RZER404'
  end

  it 'and an item leaves the warehouse' do
    # Arrange
    user = User.create!(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
                                  area:60_000, address: 'Rua do aeroporto, 3102', 
                                  cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
    supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
    product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', 
                                   weight: 5, height: 100, width: 70, depth: 75, sku: 'CAD-GAMER-RZER404')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow, status: 'pending')   
    3.times { StockProduct.create!(warehouse: warehouse, order: order, product_model: product) }
    # Act
    login_as(user)
    visit root_path
    click_on 'Guarulhos Aeroporto'
    select 'CAD-GAMER-RZER404', from: 'Item para Saída'
    fill_in 'Destinatário', with: 'Maria Ferreira'
    fill_in 'Endereço Destino', with: 'Rua das Palmeiras, 100 - Campinas - São Paulo'
    click_on 'Confirmar Retirada'
    # Assert
    expect(current_path).to eq warehouse_path(warehouse)
    expect(page).to have_content 'Item retirado com sucesso.'
    expect(page).to have_content '2 x CAD-GAMER-RZER404'
  end
end