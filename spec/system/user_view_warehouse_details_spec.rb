require 'rails_helper'

describe 'User sees details of a warehouse' do
  it 'and sees aditional info' do
    # Arrange
    w = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                      description: 'Galpão destinado para cargas internacionais.')
    w.save
    # Act
    visit '/'
    click_on 'Aeroporto SP'

    # Assert
    expect(page).to have_content 'Galpão GRU' 
    expect(page).to have_content 'Nome: Aeroporto SP'
    expect(page).to have_content 'Cidade: Guarulhos'
    expect(page).to have_content 'Área: 100000 m²'
    expect(page).to have_content 'Endereço: Avenida do Aeroporto, 1000. CEP: 15000-000'
    expect(page).to have_content 'Galpão destinado para cargas internacionais.'
  end

  it 'and goes back to homepage' do
    # Arrange
    w = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
    address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
    description: 'Galpão destinado para cargas internacionais.')
    w.save

    # Act
    visit '/'
    click_on 'Aeroporto SP'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq '/'
  end
end