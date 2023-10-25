require 'rails_helper'

describe 'User view specific supplier detail' do
  it 'and sees additional info' do
    # Arrange
    Supplier.create(corporate_name: "Logitech LTDA", brand_name: "Logitech", registration_number: '43132531',
                    full_address: "Av Brasil, 1231", city: "São Paulo", state: "SP", email: "logi@tech.com" )
    # Act
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Logitech'
    # Assert
    expect(page).to have_content 'Nome Corporativo: Logitech LTDA'
    expect(page).to have_content 'CNPJ: 43132531'
    expect(page).to have_content 'Nome da Marca: Logitech'
    expect(page).to have_content 'Endereço: Av Brasil, 1231'
    expect(page).to have_content 'Email: logi@tech.com'
    expect(page).to have_content 'Cidade: São Paulo'
    expect(page).to have_content 'Estado: SP'
  end
end