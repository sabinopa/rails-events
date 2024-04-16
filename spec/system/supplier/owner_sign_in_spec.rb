require 'rails_helper'

describe 'Supplier authenticates' do
  it 'successfully' do
    Supplier.create!(email: 'priscila@email.com', password: '12345678')
    visit root_path
    click_on 'Entrar como Fornecedor'
    within 'form' do
      fill_in 'E-mail', with: 'priscila@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    within 'nav' do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'priscila@email.com'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end
end