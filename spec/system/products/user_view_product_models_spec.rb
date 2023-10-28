require 'rails_helper'
describe 'User sees product models' do

  it 'if hes authenticated' do
    # Arrange

    # Act
    visit root_path
    within 'nav' do
      click_on 'Modelos de Produtos'
    end
    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'from navigation menu' do
    # Arrange
    user = User.create!(name: 'Gabriel', email: 'gmkoeb@gmail.com', password: 'password')
    # Act
    login_as(user) # Method imported from devise helpers
    visit root_path
    within 'nav' do
      click_on 'Modelos de Produtos'
    end
    # Assert
    expect(current_path).to eq product_models_path
  end

  it 'with success' do
    # Arrange
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronics LTDA',
                                registration_number: '4131213', full_address: 'Av Nacoes Unidas, 1000',
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, 
                         sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

    ProductModel.create!(name: 'Notebook Galaxy Book3 Ultra', weight: 3000, width: 30, height: 35, depth: 20, 
                         sku: 'NOTE-SAMSU-PCO900', supplier: supplier)

    user = User.create!(name: 'Gabriel', email: 'gmkoeb@gmail.com', password: 'password')              
    # Act
    login_as(user)
    visit root_path
    within 'nav' do
      click_on 'Modelos de Produtos'
    end
    # Assert
    expect(page).to have_content ('TV 32')
    expect(page).to have_content ('TV32-SAMSU-XPTO90')
    expect(page).to have_content ('Samsung')
    expect(page).to have_content ('Notebook Galaxy Book3 Ultra')
    expect(page).to have_content ('Samsung')
  end

  it 'and there isnt any registered products' do
    # Arrange
    user = User.create!(name: 'Gabriel', email: 'gmkoeb@gmail.com', password: 'password')
    # Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    # Assert
    expect(page).to have_content 'Não há nenhum modelo de produto cadastrado.'
  end
end