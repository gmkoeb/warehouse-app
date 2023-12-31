require 'rails_helper'

describe 'User authenticates' do
  it 'with success' do
    # Arrange
    User.create!(name: 'Gabriel', email: 'gmkoeb@gmail.com', password: 'password')
    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'gmkoeb@gmail.com'
    fill_in 'Senha', with: 'password'
    within '.actions' do
      click_on 'Entrar'
    end
    # Assert
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_button 'Sair'
    within 'nav' do
      expect(page).to have_content 'Gabriel - gmkoeb@gmail.com'
    end
  end

  it 'and logs out' do
    # Arrange
    User.create!(name: 'Gabriel', email: 'gmkoeb@gmail.com', password: 'password')
    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'gmkoeb@gmail.com'
    fill_in 'Senha', with: 'password'
    within '.actions' do
      click_on 'Entrar'
    end
    click_on 'Sair'
    # Assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_content 'gmkoeb@gmail.com'
    expect(page).not_to have_button 'Sair'
  end
end