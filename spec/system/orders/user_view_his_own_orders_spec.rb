require 'rails_helper'

describe 'User sees his own orders' do
  it 'and must be authenticated' do
    # Arrange
    # Act
    visit root_path
    click_on 'Meus Pedidos'
    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'and cant see other orders' do
    # Arrange
    gabriel = User.create!(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')

    joao = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password')
    first_warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', 
                                        area:60_000, address: 'Rua das Flores, 302', 
                                        cep: '31412', description: 'Galpão localizado na rua das flores na cidade do Rio de Janeiro' )
    second_warehouse = Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
                                         area:60_000, address: 'Rua do aeroporto, 3102', 
                                         cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
    supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')

    first_order = Order.create!(user: gabriel, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)

    second_order = Order.create!(user: gabriel, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)

    third_order = Order.create!(user: joao, warehouse: second_warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)

    # Act
    login_as(gabriel)
    visit root_path
    click_on 'Meus Pedidos'
    # Assert
    expect(page).to have_content first_order.code
    expect(page).to have_content second_order.code
    expect(page).to have_content "Status: Pendente"
    expect(page).to_not have_content third_order.code
  end

  it 'and visits an order' do
    # Arrange
    user = User.create!(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
                                  area:60_000, address: 'Rua do aeroporto, 3102', 
                                  cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
    supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)                            
    # Act
    login_as(user)
    visit root_path 
    click_on 'Meus Pedidos'                                    
    click_on order.code
    # Assert
    expect(page).to have_content 'Detalhes do Pedido'                                      
    expect(page).to have_content order.code
    expect(page).to have_content 'Galpão Destino: GRU - Guarulhos Aeroporto'
    expect(page).to have_content 'Fornecedor: Razer'
    formatted_date = I18n.localize(Date.tomorrow)
    expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}" 
  end

  it 'and cant visit other users orders' do
    # Arrange
    gabriel = User.create!(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')
    joao = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
                                  area:60_000, address: 'Rua do aeroporto, 3102', 
                                  cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
    supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
    order = Order.create!(user: gabriel, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)                            
    # Act
    login_as(joao)
    visit order_path(order)                                
    # Assert
    expect(current_path).not_to eq order_path(order)                                      
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido.'
  end

  it 'and sees order details' do
    # Arrange
    user = User.create!(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
                                  area:60_000, address: 'Rua do aeroporto, 3102', 
                                  cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
    supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
    product_a = ProductModel.create!(name: "Produto A", weight: 1, width: 10, height: 20, depth: 30, sku: 'RZER32A', supplier: supplier)
    product_b = ProductModel.create!(name: "Produto B", weight: 1, width: 10, height: 20, depth: 30, sku: 'RZER122XB', supplier: supplier)
    product_c = ProductModel.create!(name: "Produto C", weight: 1, width: 10, height: 20, depth: 30, sku: 'RZER32XBC', supplier: supplier)
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)      
    OrderItem.create!(product_model: product_a, order: order, quantity: 435)
    OrderItem.create!(product_model: product_b, order: order, quantity: 212)
    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    # Assert
    expect(page).to have_content 'Itens do Pedido'
    expect(page).to have_content '435 x Produto A'
    expect(page).to have_content '212 x Produto B'
  end

end