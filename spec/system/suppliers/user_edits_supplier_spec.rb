require 'rails_helper'

describe 'User edits a supplier' do
  it 'from navigation menu' do
    # Arrange
    supplier = Supplier.create!(corporate_name: "Logitech LTDA", brand_name: "Logitech", registration_number: '43132531',
                               full_address: "Av Brasil, 1231", city: "São Paulo", state: "SP", email: "logi@tech.com" )
    # Act
    visit root_path
    within 'nav' do 
      click_on 'Fornecedores'
    end
    click_on 'Logitech'
    click_on 'Editar'
    # Assert
    expect(current_path).to eq edit_supplier_path('logitech')
    expect(page).to have_field 'Nome corporativo', with: 'Logitech LTDA'
    expect(page).to have_field 'Nome da marca', with: 'Logitech'
    expect(page).to have_field 'CNPJ', with: '43132531'
    expect(page).to have_field 'Endereço completo', with: 'Av Brasil, 1231' 
    expect(page).to have_field 'Cidade', with: 'São Paulo'
    expect(page).to have_field 'Estado', with: 'SP'
    expect(page).to have_field 'Email', with: 'logi@tech.com'
  end

  it 'with success' do
    # Arrange
    supplier = Supplier.create!(corporate_name: "Logitech LTDA", brand_name: "Logitech", registration_number: '43132531',
                               full_address: "Av Brasil, 1231", city: "São Paulo", state: "SP", email: "logi@tech.com" )
    # Act
    visit root_path
    within 'nav' do 
      click_on 'Fornecedores'
    end
    click_on 'Logitech'
    click_on 'Editar'
    expect(current_path).to eq edit_supplier_path('logitech')
    fill_in 'Nome corporativo', with: 'Razer Eletronics'
    fill_in 'Nome da marca', with: 'Razer'
    fill_in 'CNPJ', with: '013333'
    fill_in 'Endereço', with: 'Wall Street, 666'
    fill_in 'Cidade', with: 'New York City'
    fill_in 'Estado', with: 'New York'
    fill_in 'Email', with: 'razer@gmail.com'
    click_on 'Enviar'
    # Assert
    expect(current_path).to eq supplier_path('razer')
    expect(page).to have_content 'Fornecedor atualizado com sucesso! 😊'
    expect(page).to have_content 'Razer'
    expect(page).to have_content '013333'
    expect(page).to have_content 'Wall Street, 666'
    expect(page).to have_content 'New York City'
    expect(page).to have_content 'New York'
    expect(page).to have_content 'razer@gmail.com'
  end

  it 'with missing data' do
    # Arrange
    supplier = Supplier.create!(corporate_name: "Logitech LTDA", brand_name: "Logitech", registration_number: '43132531',
                               full_address: "Av Brasil, 1231", city: "São Paulo", state: "SP", email: "logi@tech.com" )
    # Act
    visit root_path
    within 'nav' do 
      click_on 'Fornecedores'
    end
    click_on 'Logitech'
    click_on 'Editar'
    expect(current_path).to eq edit_supplier_path('logitech')
    fill_in 'Nome corporativo', with: ''
    fill_in 'Nome da marca', with: 'Razer'
    fill_in 'CNPJ', with: '013333'
    fill_in 'Endereço', with: 'Wall Street, 666'
    fill_in 'Cidade', with: 'New York City'
    fill_in 'Estado', with: 'New York'
    fill_in 'Email', with: 'razer@gmail.com'
    click_on 'Enviar'
    # Assert
    expect(current_path).to eq supplier_path('logitech')
    expect(page).to have_content 'Não foi possível atualizar o fornecedor. 😢'
  end
end