require 'rails_helper'

describe 'User removes one warehouse' do
  it 'with success' do
    # Arrange
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', 
    area:60_000, address: 'Rua das Flores, 302', 
    cep: '31412', description: 'Galpão localizado na rua das flores na cidade do Rio de Janeiro' )
    # Act
    visit root_path
    click_on 'Rio'
    click_on 'Remover'
    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão Removido com Sucesso'
    expect(page).not_to have_content 'Rio'
    expect(page).not_to have_content 'SDU'
  end

  it 'doesnt delete other warehouses' do
    # Arrange
    warehouse_1 = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', 
                                  area:60_000, address: 'Rua das Flores, 302', 
                                  cep: '31412', description: 'Galpão localizado na rua das flores na cidade do Rio de Janeiro' )

    warehouse_2 = Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', 
                    area:50_000, address: 'Rua do Aeroporto, 20', 
                    cep: '73521', description: 'Galpão localizado no aeroporto de Maceio.')
    # Act
    visit root_path
    click_on 'Rio'
    click_on 'Remover'
    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão Removido com Sucesso'
    expect(page).not_to have_content 'Rio'
    expect(page).not_to have_content 'SDU'
    expect(page).to have_content 'Maceio'
    expect(page).to have_content 'MCZ'
  end

end