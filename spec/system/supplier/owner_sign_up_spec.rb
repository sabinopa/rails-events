require 'rails_helper'

describe 'Supplier creates an account' do
  it 'successfully' do
    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    within 'form' do
      fill_in 'Nome', with: 'Priscila'
      fill_in 'Sobrenome', with: 'Sabino'
      fill_in 'E-mail', with: 'priscila@email.com'
      fill_in 'Senha', with: '12345678'
      fill_in 'Confirme sua senha', with: '12345678'
      click_on 'Criar conta'
    end

    within 'nav' do
      expect(page).not_to have_link 'Entrar como Fornecedor'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'priscila@email.com'
    end
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
  end
end