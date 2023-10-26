require 'rails_helper'

describe 'User registers a new supplier' do
  it 'from navigation menu' do
    # Arrange

    # Act
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar Fornecedor'
    # Assert
    expect(page).to have_content 'Nome corporativo'
    expect(page).to have_content 'Nome da marca'
    expect(page).to have_content 'CNPJ'
    expect(page).to have_content 'Endereço completo' 
    expect(page).to have_content 'Cidade'
    expect(page).to have_content 'Estado'
    expect(page).to have_content 'Email'
  end

  it 'with success' do
    # Arrange
    
    # Act
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar Fornecedor'
    fill_in 'Nome corporativo', with: 'Shopee LTDA'
    fill_in 'Nome da marca', with: 'Shopee'
    fill_in 'CNPJ', with: '0422'
    fill_in 'Endereço completo', with: 'R. Leopoldo Couto Magalhães Júnior, 1125'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'Email', with: 'shopee@help.shopee.br'
    click_on 'Enviar'
    # Assert
    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedor cadastrado com sucesso! 😊'
    expect(page).to have_content 'Shopee'
    expect(page).to have_content 'shopee@help.shopee.br'
    expect(page).to have_content 'R. Leopoldo Couto Magalhães Júnior, 1125'
  end

  it 'with missing data' do
    # Arrange
    
    # Act
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar Fornecedor'
    fill_in 'Nome corporativo', with: ''
    fill_in 'Nome da marca', with: 'Shopee'
    fill_in 'CNPJ', with: '0422'
    fill_in 'Endereço completo', with: 'R. Leopoldo Couto Magalhães Júnior, 1125'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'Email', with: 'shopee@help.shopee.br'
    click_on 'Enviar'
    # Assert
    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Não foi possível cadastrar o fornecedor'
    expect(page).to have_content 'Verifique os erros abaixo:'
    expect(page).to have_content 'Nome corporativo não pode ficar em branco'
  end
end