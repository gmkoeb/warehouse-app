require 'rails_helper'
describe 'User sign up' do
  it 'with success' do
    # Arrange

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Gabriel Manika'
    fill_in 'E-mail', with: 'gmkoeb@gmail.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'

    # Assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'gmkoeb@gmail.com'
    user = User.last
    expect(user.name).to eq 'Gabriel Manika'
    expect(page).to have_content 'Olá Gabriel'
    expect(page).to have_button 'Sair'
  end

  it 'with missing data' do
    # Arrange

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: 'gmkoeb@gmail.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: ''
    click_on 'Criar conta'

    # Assert
    expect(page).to have_content 'Não foi possível salvar usuário: 2 erros.'
    expect(page).to have_content 'Confirme sua senha não é igual a Senha'
    expect(page).to have_content 'Nome não pode ficar em branco'
  end
  
end