require 'rails_helper'

describe 'User registers an order' do
  it 'must be logged in' do
    # Arrange

    # Act
    visit root_path
    click_on 'Registrar Pedido'
    expect(current_path).to eq new_user_session_path
  end

  it 'with success' do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@yahoo.com', password: '123456789')

    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', 
                                  area:60_000, address: 'Rua das Flores, 302', 
                                  cep: '31412', description: 'Galpão localizado na rua das flores na cidade do Rio de Janeiro' )

    supplier = Supplier.create!(corporate_name: "Logitech LTDA", brand_name: "Logitech", registration_number: '43132531',
                                full_address: "Av Brasil, 1231", city: "São Paulo", state: "SP", email: "logi@tech.com" )

    Supplier.create!(corporate_name: "Red Dragon Eletronics", brand_name: "RedDragon", registration_number: '03132531',
                     full_address: "China Town, 1231", city: "Nova Iorque", state: "NY", email: "red@dragon.com" )                  
    Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', 
                      area:50_000, address: 'Rua do Aeroporto, 20', 
                      cep: '73521', description: 'Galpão localizado no aeroporto de Maceio.')
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC12345')                  
    # Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'SDU - Rio', from: 'Galpão'
    select supplier.brand_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: 1.day.from_now
    click_on 'Gravar'

    # Assert
    expect(page).to have_content 'Pedido registrado com sucesso.'
    expect(page).to have_content 'Pedido ABC12345'
    expect(page).to have_content 'Galpão Destino: SDU - Rio'
    expect(page).to have_content 'Fornecedor: Logitech'
    expect(page).to have_content 'Usuário Responsável: Sergio - sergio@yahoo.com'
    expect(page).to have_content "Data Prevista de Entrega:"
    expect(page).to have_content "Status: Pendente"
    expect(page).to have_content(I18n.localize(Date.today + 1))

  end

  it 'without success' do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@yahoo.com', password: '123456789')

    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', 
                                  area:60_000, address: 'Rua das Flores, 302', 
                                  cep: '31412', description: 'Galpão localizado na rua das flores na cidade do Rio de Janeiro' )

    supplier = Supplier.create!(corporate_name: "Logitech LTDA", brand_name: "Logitech", registration_number: '43132531',
                                full_address: "Av Brasil, 1231", city: "São Paulo", state: "SP", email: "logi@tech.com" )

    Supplier.create!(corporate_name: "Red Dragon Eletronics", brand_name: "RedDragon", registration_number: '03132531',
                     full_address: "China Town, 1231", city: "Nova Iorque", state: "NY", email: "red@dragon.com" )                  
    Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', 
                      area:50_000, address: 'Rua do Aeroporto, 20', 
                      cep: '73521', description: 'Galpão localizado no aeroporto de Maceio.')    
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC12345')                  
    # Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'SDU - Rio', from: 'Galpão'
    select supplier.brand_name, from: 'Fornecedor'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content 'Não foi possível registrar o pedido.'

  end
end