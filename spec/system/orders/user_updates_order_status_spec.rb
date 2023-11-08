require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do
    # Arrange
    gabriel = User.create!(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
                                  area:60_000, address: 'Rua do aeroporto, 3102', 
                                  cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
    supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
    order = Order.create!(user: gabriel, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow, status: 'pending')                              
    # Act
    login_as gabriel
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'
    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Status: Entregue'
    expect(page).to_not have_button 'Marcar como CANCELADO'
    expect(page).to_not have_button 'Marcar como ENTREGUE'
  end

  it 'e pedido foi cancelado' do
    # Arrange
    gabriel = User.create!(name: 'Gabriel', email: 'gabriel@gmail.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Guarulhos Aeroporto', code: 'GRU', city: 'Guarulhos', 
                                  area:60_000, address: 'Rua do aeroporto, 3102', 
                                  cep: '31412', description: 'Galpão localizado no aeroporto de Guarulhos' )
    supplier = Supplier.create!(corporate_name: 'Razer Eletronics', brand_name: 'Razer', registration_number: '131341', 
                                full_address: 'Wall Street, 341', city: 'New York', state: 'NY', email: 'razer@gmail.com')
    order = Order.create!(user: gabriel, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.tomorrow, status: 'pending')                              
    # Act
    login_as gabriel
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'
    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Status: Cancelado'
    expect(page).to_not have_button 'Marcar como CANCELADO'
    expect(page).to_not have_button 'Marcar como ENTREGUE'
  end
end