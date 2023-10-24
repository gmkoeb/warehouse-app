require 'rails_helper'

describe 'User edits a warehouse' do
  it 'from details page' do
    # Arrange
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', 
                    area:60_000, address: 'Rua das Flores, 302', 
                    cep: '31412', description: 'Galpão localizado na rua das flores na cidade do Rio de Janeiro' )
    # Act
    visit root_path
    click_on 'Rio'
    click_on 'Editar'
    # Assert
    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_field 'Nome', with: 'Aeroporto SP'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Código'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Área'
  end
end