require 'rails_helper'

describe 'User visits homepage' do
  it 'and sees app name' do
    # Arrange

    # Act
    visit('/')

    # Assert
    expect(page).to have_content('Galpões & Estoque')
  end

  it 'and sees registered warehouses' do
    # Arrange
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area:60_000)
    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area:50_000)

    # Act
    visit('/')

    # Assert
    expect(page).not_to have_content('Não existem galpões cadastrados.')

    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m²')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceio')
    expect(page).to have_content('50000 m²')

  end

  it 'there isnt any registered warehouses' do
    # Arrange

    # Act
    visit('/')

    # Assert
    expect(page).to have_content('Não existem galpões cadastrados.')
  end

end