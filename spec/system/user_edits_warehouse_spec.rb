require 'rails_helper'

describe 'User edits a warehouse' do
  it 'from home page' do
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
    expect(page).to have_field 'Nome', with: 'Rio'
    expect(page).to have_field 'Descrição', with: 'Galpão localizado na rua das flores na cidade do Rio de Janeiro'
    expect(page).to have_field 'Código', with: 'SDU'
    expect(page).to have_field 'Endereço', with: 'Rua das Flores, 302'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Área'
  end

  it 'with success' do
    # Arrange
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', 
                                  area:60_000, address: 'Rua das Flores, 302', 
                                  cep: '31412', description: 'Galpão localizado na rua das flores na cidade do Rio de Janeiro')
    # Act
    visit edit_warehouse_path('rio')

    fill_in 'Nome', with: 'Galpão Rio de Janeiro'
    fill_in 'Área', with: '80_000'
    fill_in 'CEP', with: '30000-900'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content 'Galpão Rio de Janeiro'
    expect(page).to have_content 'Área: 80000 m²'
    expect(page).to have_content 'Endereço: Rua das Flores, 302. CEP: 30000-900'
    expect(page).to have_content 'Galpão atualizado com sucesso!'
  end

  it 'keeps the required fields' do
    # Arrange
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', 
                                  area:60_000, address: 'Rua das Flores, 302', 
                                  cep: '31412', description: 'Galpão localizado na rua das flores na cidade do Rio de Janeiro')
    # Act
    visit edit_warehouse_path('rio')

    fill_in 'Nome', with: 'Galpão Rio de Janeiro'
    fill_in 'Área', with: '80_000'
    fill_in 'CEP', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Não foi possível atualizar o galpão'
  end
end