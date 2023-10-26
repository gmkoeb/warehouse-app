require 'rails_helper'

describe 'User edits a supplier' do
  it 'from homepage' do
    # Arrange
    Supplier.create(corporate_name: "Logitech LTDA", brand_name: "Logitech", registration_number: '43132531',
                    full_address: "Av Brasil, 1231", city: "São Paulo", state: "SP", email: "logi@tech.com" )
    # Act
    visit root_path
    within 'nav' do 
      click_on 'Fornecedores'
    end
    click_on 'Logitech'
    click_on 'Editar'
    # Assert
    expect(current_path).to eq edit_supplier_path
  end
end