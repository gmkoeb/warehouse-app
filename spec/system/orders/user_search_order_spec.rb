require 'rails_helper'

describe 'User searches for an order' do

  it 'from the navigation menu' do
    # Arrange
    user = User.create(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')
    login_as(user)
    # Act
    visit root_path
    # Assert
    within 'header nav' do
      expect(page).to have_field 'Buscar Pedido'
      expect(page).to have_button 'Buscar'
    end
  end
  
  it 'e deve estar autenticada' do
    # Arrange

    # Act
    visit root_path
    # Assert
    expect(page).to_not have_field 'Buscar Pedido'
    expect(page).to_not have_button 'Buscar'
  end

  it 'and finds the order' do
    # Arrange
    user = User.create!(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', 
                                  area:60_000, address: 'Rua das Flores, 302', 
                                  cep: '31412', description: 'Galpão localizado na rua das flores na cidade do Rio de Janeiro' )
    supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)
    # Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'
    # Assert
    expect(page).to have_content "Resultados da Busca por: #{order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content "Galpão Destino: SDU - Rio"
    expect(page).to have_content "Fornecedor: Razer"
  end

  it 'and finds multiple orders' do
    # Arrange
    user = User.create!(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')
    first_warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', 
                                  area:60_000, address: 'Rua das Flores, 302', 
                                  cep: '31412', description: 'Galpão localizado na rua das flores na cidade do Rio de Janeiro' )
    second_warehouse = Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
                                  area:60_000, address: 'Rua do aeroporto, 3102', 
                                  cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
    supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU12345')   
    first_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU84375')   
    second_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU00000')   
    third_order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow)



    # Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: 'SDU'
    click_on 'Buscar'
    # Assert
    expect(page).to have_content '2 pedidos encontrados'
    expect(page).to have_content 'SDU12345'
    expect(page).to have_content 'SDU84375'
    expect(page).to_not have_content 'Galpão Destino: GRU - Guarulhos Aeroporto'
    expect(page).to_not have_content 'GRU00000'
  end
end