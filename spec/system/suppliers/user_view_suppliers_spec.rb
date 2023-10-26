require 'rails_helper'

describe 'User sees suppliers' do
  it 'from the navigation menu' do
    # Arrange

    # Act
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    # Assert
    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedores'
  end
  
  it 'with success' do
    # Arrange
    Supplier.create(corporate_name: "Logitech LTDA", brand_name: "Logitech", registration_number: '43132531',
                    full_address: "Av Brasil, 1231", city: "São Paulo", state: "SP", email: "logi@tech.com" )
    Supplier.create(corporate_name: "Red Dragon Eletronics", brand_name: "RedDragon", registration_number: '03132531',
    full_address: "China Town, 1231", city: "Nova Iorque", state: "NY", email: "red@dragon.com" )
    # Act
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    # Assert
    expect(page).to have_content 'Logitech'
    expect(page).to have_content 'RedDragon'
    expect(page).to have_content 'Av Brasil, 1231'
    expect(page).to have_content 'China Town, 1231'
    expect(page).to have_content 'red@dragon.com'
    expect(page).to have_content 'logi@tech.com'
    expect(page).to_not have_content 'Não existe nenhum fornecedor cadastrado.'
  end

  it 'there isnt any suppliers registered' do
    # Arrange

    # Act
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    # Assert
    expect(page).to have_content 'Não existe nenhum fornecedor cadastrado.'
    expect(page).to_not have_content 'Nome'
    expect(page).to_not have_content 'Endereço'
    expect(page).to_not have_content 'Email'
  end
end