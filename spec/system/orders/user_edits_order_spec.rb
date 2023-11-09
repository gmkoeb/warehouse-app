require 'rails_helper'

describe 'usuário edita um pedido' do
  it 'e deve estar autenticado' do
    # Arrange
    user = User.create!(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
                                        area:60_000, address: 'Rua do aeroporto, 3102', 
                                        cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
    supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)                            
    # Act
    visit edit_order_path(order)                                    
    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
    area:60_000, address: 'Rua do aeroporto, 3102', 
    cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
    supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
    supplier_2 = Supplier.create!(corporate_name: "Logitech LTDA", brand_name: "Logitech", registration_number: '43132531',
                                  full_address: "Av Brasil, 1231", city: "São Paulo", state: "SP", email: "logi@tech.com" )
    supplier_3 = Supplier.create!(corporate_name: "Red Dragon Eletronics", brand_name: "RedDragon", registration_number: '03132531',
                                  full_address: "China Town, 1231", city: "Nova Iorque", state: "NY", email: "red@dragon.com" )
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)  
    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega', with: Date.tomorrow + 3
    select "RedDragon", from: 'Fornecedor'
    click_on 'Gravar'
    # Assert
    expect(page).to have_content 'Pedido atualizado com sucesso.'
    expect(page).to have_content 'Fornecedor: RedDragon'
    expect(page).to have_content "Data Prevista de Entrega: #{I18n.localize(Date.tomorrow + 3)}"
  end

  it 'caso seja o responsável' do
    # Arrange
    gabriel = User.create!(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')
    joao = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
    area:60_000, address: 'Rua do aeroporto, 3102', 
    cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
    supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
    supplier_2 = Supplier.create!(corporate_name: "Logitech LTDA", brand_name: "Logitech", registration_number: '43132531',
                                  full_address: "Av Brasil, 1231", city: "São Paulo", state: "SP", email: "logi@tech.com" )
    supplier_3 = Supplier.create!(corporate_name: "Red Dragon Eletronics", brand_name: "RedDragon", registration_number: '03132531',
                                  full_address: "China Town, 1231", city: "Nova Iorque", state: "NY", email: "red@dragon.com" )
    order = Order.create!(user: gabriel, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)  
    # Act
    login_as(joao)
    visit edit_order_path(order)
    # Assert
    expect(current_path).to eq root_path
  end
end