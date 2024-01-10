require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e não é o dono' do
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
    patch(order_path(order), params:{ order: {supplier_Id: 3} })
    # Assert
    expect(response).to redirect_to(root_path)
  end
  
end