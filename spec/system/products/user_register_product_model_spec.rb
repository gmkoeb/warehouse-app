require 'rails_helper'

describe 'User registers a product model' do
  it 'with success' do
    # Arrange
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronics LTDA',
                                registration_number: '4131213', full_address: 'Av Nacoes Unidas, 1000',
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    supplier_2 = Supplier.create!(brand_name: 'LG', corporate_name: 'LG do Brasil LTDA',
                                registration_number: '34242151', full_address: 'Av Nacoes Unidas, 1013',
                                city: 'São Paulo', state: 'SP', email: 'lgbrasil@lg.com.br')                 

    user = User.create!(name: 'Gabriel', email: 'gmkoeb@gmail.com', password: 'password')
    # Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: 'TV 40 polegadas'
    fill_in 'Peso', with: '10_000'
    fill_in 'Altura', with: '60'
    fill_in 'Largura', with: '90'
    fill_in 'Profundidade', with: '10'
    fill_in 'SKU', with: 'TV40-SAMS-XPTO'
    select 'Samsung', from: 'Fornecedor'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content 'Modelo de produto cadastrado com sucesso.'
    expect(page).to have_content 'TV 40 polegadas'
    expect(page).to have_content 'SKU: TV40-SAMS-XPTO'
    expect(page).to have_content 'Dimensões: 60cm x 90cm x 10cm'
    expect(page).to have_content 'Peso: 10000g'
    expect(page).to have_content 'Fornecedor: Samsung'
  end

  it 'with missing data' do
    # Arrange
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronics LTDA',
                                registration_number: '4131213', full_address: 'Av Nacoes Unidas, 1000',
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    supplier_2 = Supplier.create!(brand_name: 'LG', corporate_name: 'LG do Brasil LTDA',
                                registration_number: '34242151', full_address: 'Av Nacoes Unidas, 1013',
                                city: 'São Paulo', state: 'SP', email: 'lgbrasil@lg.com.br')            
    user = User.create!(name: 'Gabriel', email: 'gmkoeb@gmail.com', password: 'password')                

    # Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: '10_000'
    fill_in 'Altura', with: '60'
    fill_in 'Largura', with: '90'
    fill_in 'Profundidade', with: '10'
    fill_in 'SKU', with: ''
    select 'Samsung', from: 'Fornecedor'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content 'Não foi possível cadastrar o modelo de produto.'
  end
end