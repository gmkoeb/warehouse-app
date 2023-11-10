require 'rails_helper'

describe 'User adds items to an order' do
  it 'with success' do
    # Arrange
    user = User.create!(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
                                  area:60_000, address: 'Rua do aeroporto, 3102', 
                                  cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
    supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)   
    product_a = ProductModel.create!(name: "Produto A", weight: 1, width: 10, height: 20, depth: 30, sku: 'RZER32A', supplier: supplier)                        
    # Act
    login_as(user)                                 
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade', with: '8'
    click_on 'Gravar'

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso.'
    expect(page).to have_content '8 x Produto A'
  end

  it 'and cant see products from other supplier' do
    # Arrange
    user = User.create!(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
                                  area:60_000, address: 'Rua do aeroporto, 3102', 
                                  cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
    supplier_a = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                  full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')

    supplier_b = Supplier.create!(corporate_name: "Logitech LTDA", brand_name: "Logitech", registration_number: '43132531',
                                  full_address: "Av Brasil, 1231", city: "São Paulo", state: "SP", email: "logi@tech.com")       

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier_a, estimated_delivery_date: Date.tomorrow)   

    product_a = ProductModel.create!(name: "Produto A", weight: 1, width: 10, height: 20, depth: 30, sku: 'RZER32A', supplier: supplier_a)  

    product_b = ProductModel.create!(name: "Produto B", weight: 1, width: 10, height: 20, depth: 30, sku: 'RZER32A', supplier: supplier_b)                   
    # Act
    login_as(user)                                 
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    # Assert
    expect(page).to have_content 'Produto A'
    expect(page).to_not have_content 'Produto B'
  end
end